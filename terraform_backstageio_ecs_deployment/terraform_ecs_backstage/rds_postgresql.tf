############### SG for RDS
resource "aws_security_group" "demo_backstage_postgresql_db" {
  name        = "demo_backstage_postgresql_db_sg"
  vpc_id      = module.demo_vpc.aws_vpc_id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [module.demo_vpc.vpc_cidr]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }
}

### DB subnet group
resource "aws_db_subnet_group" "demo_backstage" {
  name       = var.project_name 
  subnet_ids = module.demo_vpc.aws_private_subnet_id
}

## RDS instance
resource "aws_db_instance" "demo_backstage" {
  db_name                   = "postgres" 
  backup_window             = "02:00-03:00"
  allocated_storage         = 20
  db_subnet_group_name      = aws_db_subnet_group.demo_backstage.id
  vpc_security_group_ids    = [aws_security_group.demo_backstage_postgresql_db.id]
  engine                    = "postgres"
  engine_version            = "16.1"
  deletion_protection       = true
  identifier                = var.project_name
  storage_encrypted         = true
  instance_class            = "db.t3.micro"
  maintenance_window        = "sun:03:00-sun:04:00"
  username                  = "postgres"
  password                  = "backstage"
}