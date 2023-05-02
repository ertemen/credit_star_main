
resource "aws_kinesis_stream" "dwh_payment" {
  name = "dwh-cstar-payment${var.staging_suffix}"
  shard_count = 1
  retention_period = var.dwh_payment_stream_retention_period

  shard_level_metrics = [
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded"]

  tags = local.tags
}
