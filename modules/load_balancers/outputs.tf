output "frontend_target_group_arn" {
  description = "ARN of frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "backend_target_group_arn" {
  description = "ARN of backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}

output "frontend_alb_dns_name" {
  description = "DNS name of frontend ALB"
  value       = aws_lb.frontend_alb.dns_name
}

output "backend_nlb_dns_name" {
  description = "DNS name of backend NLB"
  value       = aws_lb.backend_nlb.dns_name
}
