locals {
  common_tags = {
    Engineer    = var.engineer
    ProjectCode = var.project_code
    Environment = var.environment
  }
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones

  common_tags = local.common_tags
  name_prefix = var.name_prefix
}

module "s3_gateway_endpoint" {
  source = "../../modules/s3_gateway_endpoint"

  vpc_id         = module.vpc.vpc_id
  route_table_id = module.vpc.private_route_table_id
  region         = var.region

  common_tags = local.common_tags
  name_prefix = var.name_prefix
}

module "security_groups" {
  source = "../../modules/security_groups"

  vpc_id               = module.vpc.vpc_id
  bastion_allowed_cidr = var.bastion_allowed_cidr
  private_subnets      = var.private_subnets

  common_tags = local.common_tags
  name_prefix = var.name_prefix
}

module "load_balancers" {
  source = "../../modules/load_balancers"

  vpc_id = module.vpc.vpc_id

  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_sg_id      = module.security_groups.alb_sg_id
  frontend_sg_id = module.security_groups.frontend_sg_id

  common_tags = local.common_tags
  name_prefix = var.name_prefix
}

module "iam" {
  source = "../../modules/iam"

  common_tags           = local.common_tags
  name_prefix           = var.name_prefix
  console_iam_user_name = var.console_iam_user_name
  console_iam_role_name = var.console_iam_role_name
}

module "launch_templates" {
  source = "../../modules/launch_templates"

  vpc_id                    = module.vpc.vpc_id
  iam_instance_profile_name = module.iam.instance_profile_name

  bastion_sg_id        = module.security_groups.bastion_sg_id
  frontend_sg_id       = module.security_groups.frontend_sg_id
  backend_sg_id        = module.security_groups.backend_sg_id
  backend_nlb_dns_name = module.load_balancers.backend_nlb_dns_name

  common_tags = local.common_tags
  name_prefix = var.name_prefix
}

module "bastion_asg" {
  source = "../../modules/autoscaling"

  name_prefix        = "${var.name_prefix}-bastion"
  launch_template_id = module.launch_templates.bastion_launch_template_id
  subnet_ids         = [module.vpc.public_subnet_ids[0]]

  min_size         = 1
  desired_capacity = 1
  max_size         = 1

  target_group_arns = []

  common_tags = local.common_tags
}

module "frontend_asg" {
  source = "../../modules/autoscaling"

  name_prefix        = "${var.name_prefix}-frontend"
  launch_template_id = module.launch_templates.frontend_launch_template_id
  subnet_ids         = module.vpc.private_subnet_ids

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  target_group_arns = [module.load_balancers.frontend_target_group_arn]

  common_tags = local.common_tags
}

module "backend_asg" {
  source = "../../modules/autoscaling"

  name_prefix        = "${var.name_prefix}-backend"
  launch_template_id = module.launch_templates.backend_launch_template_id
  subnet_ids         = module.vpc.private_subnet_ids

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  target_group_arns = [module.load_balancers.backend_target_group_arn]

  common_tags = local.common_tags
}
