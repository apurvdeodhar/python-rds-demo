# Configure the AWS Provider using ENV vars
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
provider "aws" {
  region = var.aws_region
}

module "rds" {
  source         = "./rds"
  subnet_id_list = data.aws_subnets.subnets.ids
  vpc_cidr       = data.aws_vpc.cidr.cidr_block
  vpc_id         = var.vpc_id
}

module "iam" {
  source         = "./iam"
  aws_account_id = data.aws_caller_identity.aws_account_id.account_id
  aws_region     = var.aws_region
  rds_endpoint   = module.rds.rds_endpoint
}
