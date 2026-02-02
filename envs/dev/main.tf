locals {
  common_tags = {
    Engineer    = var.engineer
    ProjectCode = var.project_code
    Environment = var.environment
  }
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

  common_tags = local.common_tags
  name_prefix = "Data-FinalProject"
}

module "s3_gateway_endpoint" {
  source = "../../modules/s3_gateway_endpoint"

  vpc_id         = module.vpc.vpc_id
  route_table_id = module.vpc.private_route_table_id
  region         = var.region

  common_tags = local.common_tags
  name_prefix = "Data-FinalProject"
}
