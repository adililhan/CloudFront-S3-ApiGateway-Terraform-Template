locals {
  s3_origin_id     = "S3-${data.aws_s3_bucket.s3_bucket.bucket}"
  api_gw_origin_id = "API-GW-${data.aws_api_gateway_rest_api.api_gw.id}"
}