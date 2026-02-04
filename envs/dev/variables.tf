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

variable "bastion_allowed_cidr" {
  description = "CIDR block allowed to SSH into the bastion host"
  type        = string
}
