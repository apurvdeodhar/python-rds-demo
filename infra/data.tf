# Get VPC CIDR
data "aws_vpc" "cidr" {
  id = var.vpc_id
}

# Get subnet ids from VPC
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Get AWS account ID
data "aws_caller_identity" "aws_account_id" {}
