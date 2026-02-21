# Input variable: vpc_id.
variable "vpc_id" {
  description = "VPC ID where the S3 gateway endpoint will be created"
  type        = string
}

# Input variable: route_table_id.
variable "route_table_id" {
  description = "Private route table ID to associate with the S3 gateway endpoint"
  type        = string
}

# Input variable: region.
variable "region" {
  description = "AWS region"
  type        = string
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
