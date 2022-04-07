output "iam_user_creds" {
  value     = aws_iam_access_key.db_user_creds.secret
  sensitive = true
}
