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

module "s3" {
  source      = "../../../modules/s3"
  region      = var.region
  environment = var.environment
  name        = var.s3_bucket_name
}
