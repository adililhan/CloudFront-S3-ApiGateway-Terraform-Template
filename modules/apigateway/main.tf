data "aws_lambda_function" "lambda_function" {
  function_name = "${var.lambda_function_name}-${var.environment}"
}