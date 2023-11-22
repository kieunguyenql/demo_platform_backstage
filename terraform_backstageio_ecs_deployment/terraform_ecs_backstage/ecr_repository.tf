resource "aws_ecr_repository" "ecr" {
  name         = var.project_name
  image_scanning_configuration {
    scan_on_push = true
  }
}

