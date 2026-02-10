output "bastion_launch_template_id" {
  value = aws_launch_template.bastion.id
}

output "frontend_launch_template_id" {
  value = aws_launch_template.frontend.id
}

output "backend_launch_template_id" {
  value = aws_launch_template.backend.id
}
