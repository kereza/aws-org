output "gpg_encrypted_passwords" {
  value = { for temp in aws_iam_user_login_profile.user_login_profile :
    temp.user => temp.encrypted_password
  }
}