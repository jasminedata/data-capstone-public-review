variable "region" {
  description = "AWS region"
  type        = string
}

variable "engineer" {
  description = "Engineer tag"
  type        = string
}

variable "project_code" {
  description = "Project code tag"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
}

variable "bastion_allowed_cidr" {
  description = "CIDR block allowed to SSH into the bastion host"
  type        = string
}
variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "bastion_key_name" {
  description = "EC2 key pair name for bastion SSH access"
  type        = string
}

variable "console_iam_user_name" {
  description = "IAM user name to grant CloudWatch tag-read console permissions (optional)"
  type        = string
  default     = null
}

variable "console_iam_role_name" {
  description = "IAM role name to grant CloudWatch tag-read console permissions (optional)"
  type        = string
  default     = null
}
