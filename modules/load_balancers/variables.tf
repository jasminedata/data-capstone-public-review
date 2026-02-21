# Input variable: vpc_id.
variable "vpc_id" {
  description = "VPC ID where load balancers are created"
  type        = string
}

# Input variable: public_subnet_ids.
variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

# Input variable: private_subnet_ids.
variable "private_subnet_ids" {
  description = "Private subnet IDs for NLB"
  type        = list(string)
}

# Input variable: frontend_sg_id.
variable "frontend_sg_id" {
  description = "Security group ID for frontend ALB"
  type        = string
}

# Input variable: common_tags.
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

# Input variable: name_prefix.
variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

# Input variable: alb_sg_id.
variable "alb_sg_id" {
  description = "Security group ID for ALB"
  type        = string
}

