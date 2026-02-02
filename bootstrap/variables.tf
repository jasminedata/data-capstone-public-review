variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_code" {
  description = "Project Code Tag"
  type        = string
}

variable "engineer" {
  description = "Engineer tag"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}
