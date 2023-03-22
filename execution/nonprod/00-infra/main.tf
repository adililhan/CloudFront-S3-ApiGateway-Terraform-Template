provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment = var.environment
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  required_version = "1.4.0"
}

module "infra" {
  source         = "../../../modules/infra"
  environment    = var.environment
  region         = var.region
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
  vpc_cidr       = var.vpc_cidr
}
