resource "aws_ecr_repository" "frontend_app" {
  name = "frontend-app"
}
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Postgres access from EKS + your IP"
  vpc_id      = "vpc-046d82fecb3a43f6f"  # my default vpc id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open for demo, restrict later
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier        = "ecommerce-db"
  engine            = "postgres"
  engine_version    = "12.22"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  
  username          = "postgres"
  password          = var.db_password
  port              = 5432

  publicly_accessible = true
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "ecommerce-db"
  }
}
