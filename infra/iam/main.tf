# Create IAM policy to connect to DB
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.IAMPolicy.html
resource "aws_iam_user_policy" "db_user_policy" {
  name = local.user_policy_name
  user = aws_iam_user.db_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds-db:connect",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:rds-db:${var.aws_region}:${var.aws_account_id}:dbuser:${var.rds_endpoint}/${local.username}"
        ]
      },
    ]
  })
}

# Create IAM User
resource "aws_iam_user" "db_user" {
  name = local.username
  path = "/"
}

# Create AK/SK
resource "aws_iam_access_key" "db_user_creds" {
  user = aws_iam_user.db_user.name
}
