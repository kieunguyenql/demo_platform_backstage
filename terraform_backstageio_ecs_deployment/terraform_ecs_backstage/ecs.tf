###############EC2-keypair 

resource "aws_key_pair" "demo_backstage" {
  key_name   = "demo_backstage"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD6yqMrsOedXCmHCplamut5ZVs0nwe0gHv8iQNOrwTG kieunv"
}
## security group for EC2 ##############################
resource "aws_security_group" "demo_backstage_ecs_ec2_allow_internal" {
  name        = "ecs_ec2_allow_internal"
  description = "Allow internal inbound traffic"
  vpc_id      = module.demo_vpc.aws_vpc_id

 ingress {
    description      = "allow all traffic within VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks  = [module.demo_vpc.vpc_cidr] 
    security_groups = [aws_security_group.demo_backstage_external_ecs_alb.id]

    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] 
  }
}

################## Security for ELB ####################
resource "aws_security_group" "demo_backstage_external_ecs_alb" {
  name        = "allow_external_access_web"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      = module.demo_vpc.aws_vpc_id

  dynamic "ingress" {
    for_each = var.alb_listen_ports
    content {
    description      = "allow http/https from VPC"
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

####### AMI for ECS workers #########
data "aws_ami" "demo_backstage_aws_optimized_ecs" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # AWS
}

###########launch configuration ###################
resource "aws_launch_configuration" "demo_backstage_ecs_asg" {
  iam_instance_profile        = aws_iam_instance_profile.demo_backstage_ecs_agent.arn
  image_id                    = data.aws_ami.demo_backstage_aws_optimized_ecs.id
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.demo_backstage.key_name

  lifecycle {
    create_before_destroy = true
  }
  name_prefix = "demo-backstage"
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
    encrypted   = true
  }

  security_groups = [aws_security_group.demo_backstage_ecs_ec2_allow_internal.id]
  user_data       = file("user-data.sh")
}

### ECS ec2-worker autoscaling group ###
resource "aws_autoscaling_group" "demo_backstage" {
  name = "demo_backstage"
  max_size = 1
  min_size = 0
  desired_capacity = 1
  launch_configuration = aws_launch_configuration.demo_backstage_ecs_asg.name
  health_check_type = "ELB"
  vpc_zone_identifier = module.demo_vpc.aws_private_subnet_id
#  target_group_arns = [aws_lb_target_group.demo_backstage_ecs_tgp.arn]
}

######## ALB for tasks ##################

resource "aws_lb" "demo_backstage_ecs_alb" {
  name               = "demo-backstage-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demo_backstage_external_ecs_alb.id, aws_security_group.demo_backstage_ecs_ec2_allow_internal.id]
  subnets            = module.demo_vpc.aws_public_subnet_id
}

resource "aws_lb_target_group" "demo_backstage_ecs_tgp" {
  name     = "demo-backstage-ecs-tgp"
  port     = 7007
  protocol = "HTTP"
  vpc_id   = module.demo_vpc.aws_vpc_id
  health_check {
    port   = 7007
  }
}

resource "aws_autoscaling_attachment" "demo_backstage_tgp_attachment" {
  autoscaling_group_name = aws_autoscaling_group.demo_backstage.id
  lb_target_group_arn    = aws_lb_target_group.demo_backstage_ecs_tgp.arn
}

resource aws_lb_listener "demo_backstage_ecs_backstage" {
  load_balancer_arn = aws_lb.demo_backstage_ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.demo_backstage_ecs_tgp.arn
}
}
##################################### ECS_cluster ########################
resource "aws_ecs_cluster" "demo_backstage_ecs_cluster" {
    name  = var.project_name
}
# Capacity Provider acts as a link between ECS Cluster and Autoscaling Group. Each ECS Cluster can use multiple Capacity Providers and thus different Autoscaling Groups
resource "aws_ecs_capacity_provider" "demo_backstage_ecs" {
  name = "demo-backstage-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.demo_backstage.arn
    managed_scaling {
      status          = "ENABLED"
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "demo_backstage_ecs_capacity_providers" {
  cluster_name = var.project_name
  capacity_providers = [aws_ecs_capacity_provider.demo_backstage_ecs.name]
}

####### task defination ###########################
resource "aws_cloudwatch_log_group" "demo_backstage_log_group" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "demo_backstage_task" {
  family                   = "demo_backstage-task"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.demo_backstage_task_execution_role.arn
  task_role_arn            = aws_iam_role.demo_backstage_ecs_task_iam_role.arn
  container_definitions    = jsonencode([{
    name        = "demo-backstage-container"
    image       = "${var.backstage_image_url}:${var.backstage_image_tag}"
    essential   = true
    environment: [
      {"name": "BACKEND_URL", "value": "xxxxxxxxxxxx"},
      {"name": "APP_DOMAIN", "value": "xxxxxxxxxxxxxxxxx"},
      {"name": "PGSSLMODE", "value": "no-verify"},
      {"name": "POSTGRES_HOST", "value": "xxxxxxxxxxxxxxxx"},
      {"name": "POSTGRES_PORT", "value": "5432"},
      {"name": "POSTGRES_USER", "value": "postgres"},
      {"name": "POSTGRES_PASSWORD", "value": "xxxxxxxx"},
      {"name": "GITHUB_TOKEN", "value": "xxxxxxxxxxxx"},
      {"name": "AUTH_GITHUB_CLIENT_ID", "value": "xxxxxxxxxxxxx"},
      {"name": "AUTH_GITHUB_CLIENT_SECRET", "value": "xxxxxxxxxxxxxxxxxxxx"},
    ],
    logConfiguration = {
    logDriver = "awslogs"
    options: {
      "awslogs-group": "${aws_cloudwatch_log_group.demo_backstage_log_group.name}",
      "awslogs-region": "ap-southeast-2",
      "awslogs-stream-prefix": "ecs"
    }
    }
    portMappings = [{
    protocol      = "tcp"
    containerPort = 7007
    hostPort      = 7007
    }]
  }])
}
############ service###################
resource "aws_ecs_service" "demo_backstage_ecs_service" {
  name            = var.project_name
#  iam_role        = aws_iam_role.demo_backstage_ecs_service_role.arn
  cluster         = aws_ecs_cluster.demo_backstage_ecs_cluster.id
  task_definition = aws_ecs_task_definition.demo_backstage_task.arn
  desired_count   = 1
  force_new_deployment = true

  }

