# User Creation
resource "aws_iam_user" "users" {
  for_each      = toset([for i in var.iam_users : i.user])
  name          = each.key
  path          = "/"
  force_destroy = true
}

# Password creation with GPG guy provided by the user (the password will have to be changed on initial signin)
resource "aws_iam_user_login_profile" "user_login_profile" {
  for_each                = toset([for i in var.iam_users : i.user])
  user                    = aws_iam_user.users[each.key].name
  pgp_key                 = file("${path.module}/gpg_keys/${each.key}.gpg")
  password_reset_required = true
  password_length         = 10
}

#  In which group what IAM users are assigned. It comes from MAP variable
resource "aws_iam_group_membership" "tis_membership" {
  for_each   = var.iam_groups_users_map
  name       = "${each.key} Group Membership"
  group      = each.key
  users      = [for i in each.value : format("${i}%s", "@org")]
  depends_on = [aws_iam_group.groups, aws_iam_user.users]
}
