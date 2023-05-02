terraform {
  source = "${get_terragrunt_dir()}/../"
}

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    bucket = "tf-state-${get_aws_account_id()}"
    key = "cstar/${basename(dirname(get_terragrunt_dir()))}/terraform.tfstate"
    region = get_env("AWS_DEFAULT_REGION", "eu-west-1")
  }
}

inputs = {
  region = "eu-west-1"
  project_name = "cstar-dwh"
  project_name_underscored = "cstar_dwh"
  sub_project_name = "cstar-dwh-base"
  account = "ertemen"

  staging_suffix = get_env("SUFFIX", "")
  source_repository = get_env("SOURCE_REPOSITORY", "")

  firehose_common_prefix = "year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/"
  firehose_error_prefix = "result=!{firehose:error-output-type}/!{timestamp:yyyy/MM/dd}/"



  // Users
  dwh_users_s3_prefix = "dwh-cstar-users-success"
  dwh_users_s3_error_prefix = "dwh-cstar-users-error"
  users_stream_prefix = "users"

  // loan
  dwh_loan_s3_prefix = "dwh-cstar-loan-success"
  dhw_loan_s3_error_prefix = "landing-cstar-loan-error"
  loan_stream_prefix = "loan"

  // payment
  dhw_payment_s3_prefix = "landing-cstar-payment-success"
  dhw_payment_s3_error_prefix = "landing-cstar-payment-error"
  payment_stream_prefix = "payment"

  dhw_cstar_error_s3_prefix = "cstar-error"

  dhw_cstar_error_stream_prefix = "error"



  firehose_dhw_users = {
    buffer_size = 60
    buffer_interval = 128
  }

  firehose_dhw_payment = {
    buffer_size = 60
    buffer_interval = 128
  }

  firehose_dhw_loan = {
    buffer_size = 60
    buffer_interval = 128
  }




  dhw_users_stream_retention_period = 72
  dhw_payment_stream_retention_period = 72
  dhw_loan_stream_retention_period = 72

  retry_stream_lambda_enabled = true

  replica_postgres_db_name = "postgres"


}
