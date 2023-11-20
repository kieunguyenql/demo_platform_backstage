############# ECS workernode role ###########################
resource "aws_iam_role" "demo_backstage_ecs_agent" {
  name= "demo_backstage_ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# This role assumed by EC2 instance to register EC2 instance to ECS cluster
resource "aws_iam_role_policy_attachment" "demo_backstage_ecs_agent" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = aws_iam_role.demo_backstage_ecs_agent.name
}

resource "aws_iam_instance_profile" "demo_backstage_ecs_agent" {
  name = "demo_backstage_ecs-agent"
  role = aws_iam_role.demo_backstage_ecs_agent.name
}

#### ECS's Service role to manage ECS cluster######################
data "aws_iam_policy_document" "demo_backstage_ecs_service_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com",]
    }
  }
}

resource "aws_iam_role" "demo_backstage_ecs_service_role" {
  name               = "demo_backstage_ecsservice_role"
  assume_role_policy = data.aws_iam_policy_document.demo_backstage_ecs_service_policy.json
}

############# Policies for ECS's Service ########## 
data "aws_iam_policy_document" "demo_backstage_ecs_service_role_policy" {
  statement {
    effect  = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "ec2:DescribeTags",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutSubscriptionFilter",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "demo_backstage_ECS_ServiceRolePolicy"
  policy = data.aws_iam_policy_document.demo_backstage_ecs_service_role_policy.json
  role   = aws_iam_role.demo_backstage_ecs_service_role.id
}

###### The Task Execution Role grants the ECS Agent the necessary rights to write log streams

data "aws_iam_policy_document" "demo_backstage_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "demo_backstage_task_execution_role" {
  name               = "demo_backstage_ECS_TaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.demo_backstage_task_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.demo_backstage_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

############ ECS_TaskIAMRole (optional)

resource "aws_iam_role" "demo_backstage_ecs_task_iam_role" {
  name               = "demo_backstage_ECS_TaskIAMRole"
  assume_role_policy = data.aws_iam_policy_document.demo_backstage_task_assume_role_policy.json
}