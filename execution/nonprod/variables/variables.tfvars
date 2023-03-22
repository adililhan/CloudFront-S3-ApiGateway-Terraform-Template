region         = "eu-west-1"
environment    = "nonprod"
vpc_cidr       = "10.100.0.0/16"
public_subnet  = "10.100.1.0/24"
private_subnet = "10.100.2.0/24"

lambda_output_path   = "/tmp/lambda.zip"
lambda_source_dir    = "YOUR_FULL_PATH_HERE/tf/code"
lambda_function_name = "yourtestfunction"
lambda_handler       = "main.lambda_handler"
lambda_runtime       = "python3.9"

api_gateway_name   = "yourapigateway"
api_gateway_method = "GET"

s3_bucket_name = "your-s3-bucket-name"