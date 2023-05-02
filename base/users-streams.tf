
resource "aws_kinesis_stream" "dwh_users" {
  name = "dwh-cstar-users${var.staging_suffix}"
  shard_count = 1
  retention_period = var.dwh_users_stream_retention_period

  shard_level_metrics = [
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded"]

  tags = local.tags
}
