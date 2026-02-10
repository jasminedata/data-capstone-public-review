variable "common_tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Prefix for IAM resource names"
  type        = string
}
