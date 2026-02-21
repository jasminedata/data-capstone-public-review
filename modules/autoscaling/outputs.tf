# Output value: asg_name.
output "asg_name" {
  value = aws_autoscaling_group.this.name
}
