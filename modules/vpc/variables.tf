variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs (2 items)"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs (2 items)"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones (2 items) aligned with subnet lists"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Prefix for Name tag"
  type        = string
}
