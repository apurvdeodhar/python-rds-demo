terraform {
  backend "local" {}
  required_providers {
    aws = {
      version = "~> 4.8.0"
    }
    random = {
      version = ">= 3.1.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }

  required_version = "~> 1.1.7"
}
