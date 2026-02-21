# Output value: s3_endpoint_id.
output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
