resource "aws_cloudwatch_log_group" "dwh_kinesis_analytics" {
  name = "${var.project_name}-kinesis-analytics"
  retention_in_days = 90
  tags = local.tags
}

resource "aws_cloudwatch_log_group" "dwh_glue" {
  name = "${var.project_name}-glue"
  retention_in_days = 90
  tags = local.tags
}