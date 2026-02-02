variable "vpc_id" {
  description = "VPC ID where the S3 gateway endpoint will be created"
  type        = string
}

variable "route_table_id" {
  description = "Private route table ID to associate with the S3 gateway endpoint"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Prefix for Name tag"
  type        = string
}
