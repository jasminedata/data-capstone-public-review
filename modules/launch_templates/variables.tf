# Input variable: vpc_id.
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# Input variable: iam_instance_profile_name.
variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2"
  type        = string
}

# Input variable: bastion_sg_id.
variable "bastion_sg_id" {
  description = "Security group ID for bastion"
  type        = string
}

# Input variable: frontend_sg_id.
variable "frontend_sg_id" {
  description = "Security group ID for frontend"
  type        = string
}

# Input variable: backend_sg_id.
variable "backend_sg_id" {
  description = "Security group ID for backend"
  type        = string
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

# Input variable: backend_nlb_dns_name.
variable "backend_nlb_dns_name" {
  description = "Backend NLB DNS name"
  type        = string
}

# Input variable: bastion_key_name.
variable "bastion_key_name" {
  description = "EC2 key pair name for bastion SSH access"
  type        = string
}
