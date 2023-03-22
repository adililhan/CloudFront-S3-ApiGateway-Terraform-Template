resource "aws_api_gateway_rest_api" "api_gw" {
  name = var.name
}

resource "aws_api_gateway_method" "request_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  resource_id   = aws_api_gateway_rest_api.api_gw.root_resource_id
  http_method   = var.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gw_root" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  resource_id = aws_api_gateway_method.request_method.resource_id
  http_method = aws_api_gateway_method.request_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_api_gateway_deployment" "api_gw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  stage_name  = var.environment

  depends_on = [
    aws_api_gateway_integration.api_gw_root,
  ]
}

resource "aws_api_gateway_method_response" "http_200" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  resource_id = aws_api_gateway_rest_api.api_gw.root_resource_id
  http_method = aws_api_gateway_method.request_method.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "api_gw_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  resource_id = aws_api_gateway_rest_api.api_gw.root_resource_id
  http_method = aws_api_gateway_method.request_method.http_method
  status_code = aws_api_gateway_method_response.http_200.status_code

  response_templates = {
    "application/json" = ""
  }
}