region                = "ap-southeast-1"
engineer              = "Data-Jasmine"
project_code          = "Terraform101-CloudIntern"
console_iam_user_name = "Data-Cloud-Intern"
environment           = "dev"
vpc_cidr              = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

availability_zones = [
  "ap-southeast-1a",
  "ap-southeast-1b"
]

bastion_allowed_cidr = "61.245.9.122/32"
name_prefix          = "Data-FinalProject"
bastion_key_name     = "data-finalproject-bastion"

