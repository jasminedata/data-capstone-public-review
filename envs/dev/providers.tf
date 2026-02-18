terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "data-finalproject-terraform-state"
    key            = "final-project/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    use_lockfile   = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
