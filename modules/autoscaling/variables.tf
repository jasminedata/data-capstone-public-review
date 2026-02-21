# Input variable: name_prefix.
variable "name_prefix" {
  description = "Name prefix for the Auto Scaling Group"
  type        = string
}

# Input variable: launch_template_id.
variable "launch_template_id" {
  description = "Launch Template ID to use for the ASG"
  type        = string
}

# Input variable: launch_template_version.
variable "launch_template_version" {
  description = "Launch Template version"
  type        = string
  default     = "$Latest"
}

# Input variable: subnet_ids.
variable "subnet_ids" {
  description = "Subnets where instances will be launched"
  type        = list(string)
}

# Input variable: min_size.
variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

# Input variable: desired_capacity.
variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

# Input variable: max_size.
variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

# Input variable: target_group_arns.
variable "target_group_arns" {
  description = "Target group ARNs for the ASG"
  type        = list(string)
}

# Input variable: health_check_type.
variable "health_check_type" {
  description = "ASG health check type (EC2 or ELB)"
  type        = string
  default     = "ELB"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "health_check_type must be either EC2 or ELB."
  }
}

# Input variable: common_tags.
variable "common_tags" {
  description = "Common tags applied to instances"
  type        = map(string)
}

# Input variable: enable_scaling_policies.
variable "enable_scaling_policies" {
  description = "Whether to create CPU-based scaling policies and alarms"
  type        = bool
  default     = true
}

# Input variable: enable_instance_refresh.
variable "enable_instance_refresh" {
  description = "Whether to enable rolling instance refresh for launch template updates"
  type        = bool
  default     = false
}

# Input variable: instance_refresh_min_healthy_percentage.
variable "instance_refresh_min_healthy_percentage" {
  description = "Minimum healthy percentage during instance refresh"
  type        = number
  default     = 50
}

# Input variable: instance_refresh_warmup.
variable "instance_refresh_warmup" {
  description = "Warmup time in seconds between refresh steps"
  type        = number
  default     = 180
}
