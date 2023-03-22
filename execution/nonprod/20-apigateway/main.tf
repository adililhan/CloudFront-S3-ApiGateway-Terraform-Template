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

module "apigateway" {
  source               = "../../../modules/apigateway"
  environment          = var.environment
  name                 = var.api_gateway_name
  method               = var.api_gateway_method
  lambda_function_name = var.lambda_function_name
}
