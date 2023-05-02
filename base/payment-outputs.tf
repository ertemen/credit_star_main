
output "dwh_payment_stream_arn" {
  value = aws_kinesis_stream.dwh_payment.arn
}

output "dwh_payment_stream_name" {
  value = aws_kinesis_stream.dwh_payment.name
}
