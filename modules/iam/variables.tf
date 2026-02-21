# Input variable: common_tags.
variable "common_tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
}

# Input variable: name_prefix.
variable "name_prefix" {
  description = "Prefix for IAM resource names"
  type        = string
}

# Input variable: console_iam_user_name.
variable "console_iam_user_name" {
  description = "IAM user name to grant CloudWatch tag-read console permissions (optional)"
  type        = string
  default     = null
}

# Input variable: console_iam_role_name.
variable "console_iam_role_name" {
  description = "IAM role name to grant CloudWatch tag-read console permissions (optional)"
  type        = string
  default     = null
}
