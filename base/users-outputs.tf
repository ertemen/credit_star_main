
output "dwh_users_stream_arn" {
  value = aws_kinesis_stream.dwh_users.arn
}

output "dwh_users_stream_name" {
  value = aws_kinesis_stream.dwh_users.name
}
