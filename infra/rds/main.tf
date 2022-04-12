# Create subnet group
resource "aws_db_subnet_group" "subnet_group" {
  name       = "postgres-db-subnet-group"
  subnet_ids = var.subnet_id_list
}
# Create security group
resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = local.rds_sg_name
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate random password
resource "random_password" "rds_master_pass" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  keepers = {
    pass_version = 1
  }
}
# Create DB instance
resource "aws_db_instance" "rds" {
  engine                              = local.engine
  engine_version                      = local.engine_version
  instance_class                      = local.instance_class
  identifier                          = local.rds_name
  iam_database_authentication_enabled = true
  username                            = local.master_username
  db_name                             = local.db_name
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  parameter_group_name                = local.parameter_group_name
  password                            = random_password.rds_master_pass.result
  multi_az                            = false
  vpc_security_group_ids              = [aws_security_group.sg.id]
  allocated_storage                   = local.allocated_storage
  deletion_protection                 = false
  skip_final_snapshot                 = true
  apply_immediately                   = true
}

# Create DB and DB user
resource "null_resource" "post_db_job" {
  depends_on = [aws_db_instance.rds] #wait for the db to be ready
    provisioner "local-exec" {
    interpreter = ["/bin/sh", "-c"]
    working_dir = "./"
    command     = <<-EOT
        export PGPASSWORD='${random_password.rds_master_pass.result}'
        psql --host=${aws_db_instance.rds.endpoint} --port=5432 --username=${local.master_username} --dbname=${local.db_name} < query.sql
    EOT
    }
}
