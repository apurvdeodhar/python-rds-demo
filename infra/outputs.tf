output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  description = "RDS endpoint"
}

output "iam_user_creds" {
  value       = module.iam.iam_user_creds
  description = "IAM user creds"
  sensitive   = true
}
