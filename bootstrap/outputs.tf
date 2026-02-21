# Output value: state_bucket_name.
output "state_bucket_name" {
  value = aws_s3_bucket.tf_state.bucket
}

# Output value: region.
output "region" {
  value = var.region
}
