# Input variable: region.
variable "region" {
  description = "AWS region"
  type        = string
}

# Input variable: project_code.
variable "project_code" {
  description = "Project Code Tag"
  type        = string
}

# Input variable: engineer.
variable "engineer" {
  description = "Engineer tag"
  type        = string
}

# Input variable: name_prefix.
variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

# Input variable: state_bucket_name.
variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
}
