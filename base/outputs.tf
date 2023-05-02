# --- S3 --- BEGIN

output "dg_jobs_bucket_name" {
  value = aws_s3_bucket.cstar_jobs.id
}

output "dg_jobs_bucket_arn" {
  value = aws_s3_bucket.cstar_jobs.arn
}

output "dg_events_bucket_name" {
  value = aws_s3_bucket.events.id
}

output "dg_events_bucket_arn" {
  value = aws_s3_bucket.events.arn
}

output "dg_glue_temp_bucket_name" {
  value = aws_s3_bucket.glue_temp.id
}

output "dg_glue_temp_bucket_arn" {
  value = aws_s3_bucket.glue_temp.arn
}

output "dg_cstar_dms_bucket_name" {
  value = aws_s3_bucket.cstar_jobs.id
}

output "dg_cstar_dms_bucket_arn" {
  value = aws_s3_bucket.cstar_jobs.arn
}

# --- Glue --- BEGIN

output "glue_database_data_gateway_dwh_name" {
  value = aws_glue_catalog_database.cstar_dwh.name
}

output "glue_database_data_gateway_dwh_arn" {
  value = aws_glue_catalog_database.cstar_dwh.arn
}

# --- Glue --- END


# --- Miscellaneous --- BEGIN
output "kinesis_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.dwh_kinesis_analytics.name
}

output "kinesis_cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.dwh_kinesis_analytics.arn
}

output "glue_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.dwh_glue.name
}

output "glue_cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.dwh_glue.arn
}




