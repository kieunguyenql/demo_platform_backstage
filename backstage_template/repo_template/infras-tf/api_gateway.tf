
locals {
  http_methods  = ["PATCH","DELETE","POST","GET"]
}

locals {
  url_path = ["health", "products", "product" ]  
}

resource "aws_api_gateway_rest_api" "demo_backstage" {
  name        = var.api_gate_way_name
  description = "demo API"
}

resource "aws_api_gateway_resource" "url_path" {
  for_each    = toset(local.url_path)
  path_part   = each.value
  rest_api_id = aws_api_gateway_rest_api.demo_backstage.id
  parent_id   = aws_api_gateway_rest_api.demo_backstage.root_resource_id
}

resource "aws_api_gateway_method" "health_get" {
  rest_api_id   = aws_api_gateway_rest_api.demo_backstage.id
  resource_id   = aws_api_gateway_resource.url_path["health"].id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "products_get" {
  rest_api_id   = aws_api_gateway_rest_api.demo_backstage.id
  resource_id   = aws_api_gateway_resource.url_path["products"].id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "product_curd_medthods" {
  for_each      = toset(local.http_methods)
  http_method   = each.value
  rest_api_id   = aws_api_gateway_rest_api.demo_backstage.id
  resource_id   = aws_api_gateway_resource.url_path["product"].id
  authorization = "NONE"
}

resource "aws_api_gateway_deployment" "demo_backstage" {
  depends_on    = [aws_api_gateway_resource.url_path, aws_api_gateway_method.health_get, aws_api_gateway_method.products_get, aws_api_gateway_method.product_curd_medthods,
                aws_api_gateway_integration.health_integration, aws_api_gateway_integration.product_integration_delete, aws_api_gateway_integration.product_integration_get,
                aws_api_gateway_integration.product_integration_patch, aws_api_gateway_integration.product_integration_post, aws_api_gateway_integration.products_integration]
  rest_api_id   = aws_api_gateway_rest_api.demo_backstage.id
  stage_name    = "demo"
}

#resource "aws_api_gateway_stage" "demo_backstage" {
#  deployment_id = aws_api_gateway_deployment.demo_backstage.id
#  rest_api_id   = aws_api_gateway_rest_api.demo_backstage.id
#  stage_name    = "demo"
#}


#####################
resource "aws_api_gateway_integration" "health_integration" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["health"].id
  http_method             = aws_api_gateway_method.health_get.http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_api_gateway_integration" "products_integration" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["products"].id
  http_method             = aws_api_gateway_method.products_get.http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_api_gateway_integration" "product_integration_get" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["product"].id
  http_method             = aws_api_gateway_method.product_curd_medthods["GET"].http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}
resource "aws_api_gateway_integration" "product_integration_patch" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["product"].id
  http_method             = aws_api_gateway_method.product_curd_medthods["PATCH"].http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}
resource "aws_api_gateway_integration" "product_integration_post" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["product"].id
  http_method             = aws_api_gateway_method.product_curd_medthods["POST"].http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}
resource "aws_api_gateway_integration" "product_integration_delete" {
  rest_api_id             = aws_api_gateway_rest_api.demo_backstage.id
  resource_id             = aws_api_gateway_resource.url_path["product"].id
  http_method             = aws_api_gateway_method.product_curd_medthods["DELETE"].http_method
  integration_http_method = "POST"  # You can specify the integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.demo_backstage.execution_arn}/*"
}

