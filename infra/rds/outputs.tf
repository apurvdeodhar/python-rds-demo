output "rds_endpoint" {
  value       = aws_db_instance.rds.address
  description = "RDS endpoint"
}
