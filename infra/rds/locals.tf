locals {
  # RDS details
  rds_sg_name          = "python-rds-demo-sg"
  rds_name             = "python-rds-demo"
  engine               = "postgres"
  engine_version       = "12.8"
  instance_class       = "db.t3.micro"
  allocated_storage    = "20"
  parameter_group_name = "default.postgres12"
  master_username      = "demo"

  # db details
  db_username = "demo"
  db_name     = "demo"
}
