
variable "dwh_cstar_payment_s3_prefix" {}
variable "dwh_cstar_payment_s3_error_prefix" {}
variable "payment_cstar_stream_prefix" {}



variable "firehose_dwh_cstar_payment" {
  type = object({
    buffer_size = number
    buffer_interval = number
  })
  default = {
    buffer_size = 128
    buffer_interval = 60
  }
}

# --- Kinesis Stream Variables --- BEGIN
variable "dwh_payment_stream_retention_period" {}
# --- Kinesis Stream Variables --- END