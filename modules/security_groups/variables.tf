# Input variable: vpc_id.
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# Input variable: bastion_allowed_cidr.
variable "bastion_allowed_cidr" {
  description = "CIDR block allowed to SSH into bastion host"
  type        = string
}

# Input variable: private_subnets.
variable "private_subnets" {
  description = "Private subnet CIDR blocks used for internal traffic (including NLB nodes)"
  type        = list(string)
}

# Input variable: common_tags.
variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

# Input variable: name_prefix.
variable "name_prefix" {
  description = "Name prefix"
  type        = string
}
