# Data source: aws_instances.bastion.
data "aws_instances" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["${var.name_prefix}-BastionHost"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

# Output value: frontend_alb_dns_name.
output "frontend_alb_dns_name" {
  value = module.load_balancers.frontend_alb_dns_name
}

# Output value: backend_nlb_dns_name.
output "backend_nlb_dns_name" {
  value = module.load_balancers.backend_nlb_dns_name
}

# Output value: bastion_public_ip.
output "bastion_public_ip" {
  value = try(data.aws_instances.bastion.public_ips[0], null)
}
