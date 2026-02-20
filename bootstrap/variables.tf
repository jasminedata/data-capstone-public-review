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

variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
}
