variable "vpc_id" {
  description = "VPC ID where load balancers are created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for NLB"
  type        = list(string)
}

variable "frontend_sg_id" {
  description = "Security group ID for frontend ALB"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}
