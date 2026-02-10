variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID for bastion"
  type        = string
}

variable "frontend_sg_id" {
  description = "Security group ID for frontend"
  type        = string
}

variable "backend_sg_id" {
  description = "Security group ID for backend"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "name_prefix" {
  description = "Name prefix"
  type        = string
}
