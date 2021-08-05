resource "aws_iam_account_password_policy" "pass" {
  minimum_password_length        = 10
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24
  max_password_age               = 360
}