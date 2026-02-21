# Output value: bastion_launch_template_id.
output "bastion_launch_template_id" {
  value = aws_launch_template.bastion.id
}

# Output value: frontend_launch_template_id.
output "frontend_launch_template_id" {
  value = aws_launch_template.frontend.id
}

# Output value: backend_launch_template_id.
output "backend_launch_template_id" {
  value = aws_launch_template.backend.id
}
