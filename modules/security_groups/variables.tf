variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "bastion_allowed_cidr" {
  description = "CIDR block allowed to SSH into bastion host"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks used for internal traffic (including NLB nodes)"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "name_prefix" {
  description = "Name prefix"
  type        = string
}
