data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = var.function_name
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-policy.json
}

data "aws_iam_policy_document" "common_policies" {
  statement {
    sid = "lambdaEc2Policy"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeVpcs",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
    ]
    resources = ["*"]  
   }

  statement {
    sid = "lambdaDynamo"
    effect = "Allow"
    actions = [
      "dynamodb:*",
    ]
    resources = ["*"]  
  }
}

resource "aws_iam_policy" "lambda_common_policy" {
  policy = data.aws_iam_policy_document.common_policies.json
  name   = "${var.function_name}"
}

resource "aws_iam_role_policy_attachment" "lambda_common_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_common_policy.arn
}
