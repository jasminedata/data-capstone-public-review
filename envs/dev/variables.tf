# Input variable: region.
variable "region" {
  description = "AWS region"
  type        = string
}

# Input variable: engineer.
variable "engineer" {
  description = "Engineer tag"
  type        = string
}

# Input variable: project_code.
variable "project_code" {
  description = "Project code tag"
  type        = string
}

# Input variable: environment.
variable "environment" {
  description = "Environment name"
  type        = string
}
# Input variable: vpc_cidr.
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Input variable: public_subnets.
variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

# Input variable: private_subnets.
variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

# Input variable: availability_zones.
variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
}

# Input variable: bastion_allowed_cidr.
variable "bastion_allowed_cidr" {
  description = "CIDR block allowed to SSH into the bastion host"
  type        = string
}
# Input variable: name_prefix.
variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

# Input variable: bastion_key_name.
variable "bastion_key_name" {
  description = "EC2 key pair name for bastion SSH access"
  type        = string
}

# Input variable: console_iam_user_name.
variable "console_iam_user_name" {
  description = "IAM user name to grant CloudWatch tag-read console permissions"
  type        = string
  default     = null
}

# Input variable: console_iam_role_name.
variable "console_iam_role_name" {
  description = "IAM role name to grant CloudWatch tag-read console permissions"
  type        = string
  default     = null
}
