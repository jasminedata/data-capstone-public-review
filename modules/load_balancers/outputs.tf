# Frontend ALB Outputs
output "frontend_alb_arn" {
  description = "ARN of the frontend Application Load Balancer"
  value       = aws_lb.frontend_alb.arn
}

output "frontend_alb_dns_name" {
  description = "DNS name of the frontend Application Load Balancer"
  value       = aws_lb.frontend_alb.dns_name
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}

# Backend NLB Outputs
output "backend_nlb_arn" {
  description = "ARN of the backend Network Load Balancer"
  value       = aws_lb.backend_nlb.arn
}

output "backend_nlb_dns_name" {
  description = "DNS name of the backend Network Load Balancer"
  value       = aws_lb.backend_nlb.dns_name
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}
