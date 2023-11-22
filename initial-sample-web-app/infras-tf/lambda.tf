########## LAmbda layer ###########
resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name          = "${var.function_name}-python-packages"
  description         = "Python packages for ${var.function_name}"
  compatible_runtimes = var.compatible_runtimes
  filename            = "./packages.zip"
  lifecycle {
    ignore_changes = [source_code_hash, description]
  }
}


####### Lambda function #######
resource "aws_lambda_function" "lambda_function" {

  function_name = var.function_name
  description   = var.description
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.lambda_role.arn
  filename      = "./packages.zip"

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  layers = [aws_lambda_layer_version.lambda_layer.arn]

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
      description,
      timeout,
      memory_size,
      environment,
      handler,
      layers
    ]
  }
  publish = true
}


############ cloudwatch logs group for lambda ##############
# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
resource "aws_cloudwatch_log_group" "demo_backstage" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 1
}

