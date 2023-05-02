
output "dwh_loan_stream_arn" {
  value = aws_kinesis_stream.dwh_loan.arn
}

output "dwh_loan_stream_name" {
  value = aws_kinesis_stream.dwh_loan.name
}
