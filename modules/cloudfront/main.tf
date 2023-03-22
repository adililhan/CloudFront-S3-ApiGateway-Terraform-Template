data "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

data "aws_api_gateway_rest_api" "api_gw" {
  name = var.api_gateway_name
}