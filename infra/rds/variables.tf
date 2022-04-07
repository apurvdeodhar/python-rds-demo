variable "subnet_id_list" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}
