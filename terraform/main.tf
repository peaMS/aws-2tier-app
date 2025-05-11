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

resource "aws_instance" "db" {
  ami           = "ami-0dd574ef87b79ac6c" # Amazon Linux 2 (eu north)
  instance_type = "t3.micro"
  key_name      = "mykey"
  vpc_security_group_ids = ["sg-0861be155fde3f23c"]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable postgresql14
              yum install postgresql-server postgresql -y
              postgresql-setup initdb
              systemctl start postgresql
              systemctl enable postgresql
              sudo -u postgres psql -c "CREATE DATABASE appdb;"
              sudo -u postgres psql -c "CREATE USER appuser WITH PASSWORD 'password';"
              sudo -u postgres psql -d appdb -c "CREATE TABLE messages (id SERIAL PRIMARY KEY, message TEXT);"
              EOF
}
