provider "aws" {
    region = "us-east-1"
}
module "postgres" {
  source         = "../template"
  name           = var.name
  vpc_id         = var.vpc_id
  cidr           = var.cidr
  storage_size   = var.storage_size
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name        = var.db_name
  username       = var.username
  group_name     = var.group_name
  snapshot       = var.snapshot
}

# terraform {
#   backend "s3" {
#     bucket         = "postgres-rds-bucket"
#     key            = "../module/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "postgres-rds-bucket"
#     encrypt        = true
#   }
# }

