# Local values reused in this file.
locals {
  common_tags = {
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# ----------------------------
# S3 Bucket for Terraform State
# ----------------------------
resource "aws_s3_bucket" "tf_state" {
  bucket = var.state_bucket_name

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-TerraformStateBucket"
    }
  )
}

# Enable versioning
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
