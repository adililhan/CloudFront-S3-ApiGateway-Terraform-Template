resource "aws_lambda_function" "lambda_function" {
  filename         = var.output_path
  function_name    = "${var.function_name}-${var.environment}"
  role             = aws_iam_role.iam_role.arn
  handler          = var.handler
  source_code_hash = data.archive_file.zip_file.output_base64sha256
  runtime          = var.runtime
  vpc_config {
    subnet_ids         = [data.aws_subnet.private_subnet.id]
    security_group_ids = [data.aws_security_group.infra_common_sg.id]
  }
}