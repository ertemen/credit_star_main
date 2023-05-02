import boto3
import json

client = boto3.client('glue')

# kinesis ARN of the event source that triggers the Lambda function
#  ['arn:aws:kinesis:eu-west-1:4584565677:stream', 'loan-stream']
# event['Records'][0]['kinesis']['sequenceNumber']
# returns the sequence number of the record that triggered the Lambda function.
# This information can be passed to the Glue job as an argument
# so that the job can process the new data in the Kinesis stream
# starting from this sequence number.


def lambda_handler(event, context):
    loan_stream = event['Records'][0]['eventSourceARN'].split('/')[1]
    payment_stream = event['Records'][0]['eventSourceARN'].split('/')[1]
    loan_records = event['Records'][0]['kinesis']['sequenceNumber']
    payment_records = event['Records'][0]['kinesis']['sequenceNumber']

    glue_job_name = 'cstar-credit-decision-job'
    glue_job_arguments = {
        '--loan-stream': loan_stream,
        '--payment-stream': payment_stream,
        '--loan-records': loan_records,
        '--payment-records': payment_records
    }

    response = client.start_job_run(JobName=glue_job_name, Arguments=glue_job_arguments)

   # print(response)


    return {
        'statusCode': 200,
        'body': json.dumps('Glue job started')
    }
