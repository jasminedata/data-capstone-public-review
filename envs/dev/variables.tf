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
