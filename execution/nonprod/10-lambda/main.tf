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

module "lambda" {
  source        = "../../../modules/lambda/"
  output_path   = var.lambda_output_path
  source_dir    = var.lambda_source_dir
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  environment   = var.environment
}
