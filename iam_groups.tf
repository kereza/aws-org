/*
Group Creation
*/

resource "aws_iam_group" "groups" {
  for_each = var.iam_groups_acc_map
  name     = each.key
}

# MFA Policy so every user/group can manage its own MFA device
# Attached to every IAM Group
resource "aws_iam_policy" "aws_organization_self_manage" {
  name   = "SelfManageMFA"
  path   = "/"
  policy = templatefile("${path.module}/group_policies/self_manage.json", {})
}

# Default Policy for every IAM Group
resource "aws_iam_policy" "default_org_policy" {
  for_each = var.iam_groups_acc_map
  name     = each.key
  path     = "/"
  policy   = templatefile("${path.module}/group_policies/default.json", { acc_id = each.value, group_name = each.key })
}

# Attaching default policies to TIS IAM groups
resource "aws_iam_group_policy_attachment" "org_default" {
  for_each   = var.iam_groups_acc_map
  group      = each.key
  policy_arn = aws_iam_policy.default_org_policy[each.key].arn
  depends_on = [aws_iam_group.groups]
}

resource "aws_iam_group_policy_attachment" "self_manage" {
  for_each   = var.iam_groups_acc_map
  group      = each.key
  policy_arn = aws_iam_policy.aws_organization_self_manage.arn
  depends_on = [aws_iam_group.groups]
}
