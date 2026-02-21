# Output value: bastion_sg_id.
output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

# Output value: frontend_sg_id.
output "frontend_sg_id" {
  value = aws_security_group.frontend.id
}

# Output value: backend_sg_id.
output "backend_sg_id" {
  value = aws_security_group.backend.id
}

# Output value: alb_sg_id.
output "alb_sg_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}
