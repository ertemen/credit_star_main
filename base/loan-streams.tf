
resource "aws_kinesis_stream" "dwh_loan" {
  name = "dwh-cstar-loan${var.staging_suffix}"
  shard_count = 1
  retention_period = var.dwh_loan_stream_retention_period

  shard_level_metrics = [
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded"]

  tags = local.tags
}
