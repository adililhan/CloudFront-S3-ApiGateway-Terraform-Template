# CloudFront-S3-ApiGateway-Terraform-Template

## How to Deploy Terraform Scripts?

Since the repository contains many modules, you must run them in the correct sequence.

## Warning

Some of the modules may not be suited for production use since this is a demonstration of how to utilize CloudFront, S3, and API Gateway. For example, public access to the S3 bucket will be granted.

--------

Please populate `execution/nonprod/variables/variables.tfvars` with your values.

After that, go to `execution/nonprod/00-infra` and run `terraform init`

In the same directory, run terraform plan: `terraform plan -var-file=../variables/variables.tfvars --out=tfplan`

This command will generate a plan file in the same directory.

You may want to apply the plan: `terraform apply tfplan`

After implementing the plan, move on to the other modules and follow the same steps in the other modules. Please follow the module numbers in `execution/nonprod` folder.

## Modules

The repository contains 5 different modules:

1) **Module for Infrastructure**

The Infra module will create VPC, subnets, elastic IP and security group.

An IPv4 address and an IPv6 address will be exported.

2) **Module for Lambda**

The Lambda module will upload the Lambda function in the code directory to AWS. Besides, it will create an IAM Role for the lambda function.

3) **Module for API Gateway**

The API Gateway module will construct an API Gateway and link it to the Lambda function that was generated in the previous phase.

The URL of the generated API Gateway will be exported.

4) **Module for S3 Bucket**

The S3 Bucket will construct an S3 Bucket with **Public access**.

5) **Module for CloudFront**

The CloudFront module will construct an CloudFront distribution. Together with the behavior patterns, two origins (one for S3, one for API Gateway) will be created in the distribution.

The URL of the generated CloudFront distribution will be exported.

## How to test?

In the S3 bucket, create a folder called `images` and upload a file called `car.jpg` to that folder.

Send a request to: `https://CLOUDFRONT_URL/ENVIRONMENT` and `https://CLOUDFRONT_URL/images/car.jpg`

In the `variables.tfvars` file, you can set the environment name for the CloudFront URL.

P.S.: You can find the `data` blocks in the `main.tf` file of the relevant module. Thus, you can see the external dependencies of a module.