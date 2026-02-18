output "frontend_alb_dns_name" {
  value = module.load_balancers.frontend_alb_dns_name
}

output "backend_nlb_dns_name" {
  value = module.load_balancers.backend_nlb_dns_name
}
