##SG
resource "aws_security_group" "allow_tls" {
  name        = "${var.name}_allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = "5432"
    to_port          = "5432"
    protocol         = "tcp"
    cidr_blocks      = [var.cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_db_instance" "postgres" {
  allocated_storage    = var.storage_size
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.username
  password             = random_password.password.result
  parameter_group_name = var.group_name
  skip_final_snapshot  = var.snapshot
}

##SECRET
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%&"
}

resource "aws_secretsmanager_secret" "db-pass" {
  name = "${var.name}-db-pass"
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id     = aws_secretsmanager_secret.db-pass.id
  secret_string = random_password.password.result
}

