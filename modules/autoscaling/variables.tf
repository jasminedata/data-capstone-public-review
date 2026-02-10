variable "name_prefix" {
  description = "Name prefix for the Auto Scaling Group"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID to use for the ASG"
  type        = string
}

variable "launch_template_version" {
  description = "Launch Template version"
  type        = string
  default     = "$Latest"
}

variable "subnet_ids" {
  description = "Subnets where instances will be launched"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "target_group_arns" {
  description = "Target group ARNs for the ASG"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags applied to instances"
  type        = map(string)
}
