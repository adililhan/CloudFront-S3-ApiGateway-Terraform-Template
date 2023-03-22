resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${var.lambda_function_name}-${var.environment}"
  statement_id  = "AllowExecutionFrom${var.name}"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gw.execution_arn}/*/${var.method}/"

  depends_on = [
    aws_api_gateway_rest_api.api_gw,
  ]
}