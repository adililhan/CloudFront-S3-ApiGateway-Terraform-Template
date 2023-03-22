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

module "cloudfront" {
  source           = "../../../modules/cloudfront"
  region           = var.region
  environment      = var.environment
  s3_bucket_name   = var.s3_bucket_name
  api_gateway_name = var.api_gateway_name
}
