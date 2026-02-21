# Input variable: vpc_cidr.
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

# Input variable: public_subnets.
variable "public_subnets" {
  description = "Public subnet CIDRs (2 items)"
  type        = list(string)
}

# Input variable: private_subnets.
variable "private_subnets" {
  description = "Private subnet CIDRs (2 items)"
  type        = list(string)
}

# Input variable: availability_zones.
variable "availability_zones" {
  description = "Availability zones (2 items) aligned with subnet lists"
  type        = list(string)
}

# Input variable: common_tags.
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

# Input variable: name_prefix.
variable "name_prefix" {
  description = "Prefix for Name tag"
  type        = string
}
