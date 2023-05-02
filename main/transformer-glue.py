import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.dynamicframe import DynamicFrame
from awsglue.job import Job
from pyspark.sql.functions import *
from datetime import datetime, timedelta

args = getResolvedOptions(sys.argv, ['JOB_NAME', 'loan-stream', 'payment-stream', 'loan-records', 'payment-records'])


sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Create dynamic frames from Kinesis streams
loan_stream = glueContext.create_data_frame.from_catalog(database=args['loan-stream'], table_name="loan_stream", transformation_ctx="loan_stream").toDF()
payment_stream = glueContext.create_data_frame.from_catalog(database=args['payment-stream'], table_name="payment_stream", transformation_ctx="payment_stream").toDF()

# Extract the required columns from loan and payment dataframes
loan = loan_stream.select("id", "client_id", "created_on", "amount", "matured_on", "status")
payment = payment_stream.select("loan_id", "amount", "principle", "interest", "status", "created_on")

# Calculate metrics only for new loans where status = application
client_raw = loan.filter(col("status") == "application")

# Aggregate data to get count of previously paid loans for each client of whom making new credit application
client_loans = client_raw.filter(col("status") == "paid").groupBy("client_id").agg(countDistinct("id").alias("paid_loans_count"))

# Aggregate data to get count of days since last late payment done by each client
client_late_payment = payment.filter(col("status") == "late").groupBy("loan_id").agg(max("created_on").alias("last_late_payment"))
client_late_payment = client_raw.join(client_late_payment, loan["id"] == client_late_payment["loan_id"], "left_outer")
client_late_payment = client_late_payment.select("client_id", datediff(current_date(), col("last_late_payment")).alias("days_since_last_late_payment"))

# Aggregate data to get sum of interest payment amount received from loans issued in the last 90 days for each client
ninety_days_ago = datetime.now() - timedelta(days=90)
recent_loans = client_raw.filter(col("status") == "paid").filter(col("matured_on") > ninety_days_ago)
interest_payments = payment.filter(col("status") == "paid").join(recent_loans, payment["loan_id"] == recent_loans["id"], "inner")
client_interest_payments = interest_payments.groupBy("client_id").agg(sum("interest").alias("interest_payments"), sum("amount").alias("loan_amounts"))
client_profit = client_interest_payments.withColumn("profit_in_last_90_days_rate", col("interest_payments")/col("loan_amounts"))

# Join all the above dataframes to get required attributes for each client
client_attributes = client_loans.join(client_late_payment, "client_id", "outer").join(client_profit, "client_id", "outer")
client_attributes = client_attributes.fillna(0, ["paid_loans_count", "days_since_last_late_payment", "profit_in_last_90_days_rate"])

# Write the final dataframe to the users table
users = glueContext.create_dynamic_frame.from_catalog(database="streaming_db", table_name="users").toDF()
final_data = users.join(client_attributes, "client_id", "left_outer")

# Write the final dataframe to S3 bucket
glueContext.write_dynamic_frame.from_options(
    frame=DynamicFrame.fromDF(final_data, glueContext, "final_data"),
    connection_type="s3",
    connection_options={
        "path": "s3://cstar_dwh:43534/users/2023/04/30/",
        "partitionKeys": ["id"]
    }
)
