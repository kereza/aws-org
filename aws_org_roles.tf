data "aws_iam_policy_document" "aws_organization_root_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.master_acc_id}:root"]
    }
  }
}


########

resource "aws_iam_role" "sub_acc_roles" {
  for_each             = toset(var.sub_roles)
  description          = "Roles for subaccounts"
  name                 = "OrganizationAccount${each.value}AccessRole"
  path                 = "/"
  max_session_duration = var.max_session_duration
  assume_role_policy   = data.aws_iam_policy_document.aws_organization_root_trust.json
}

resource "aws_iam_policy" "tis_sub_acc_boundary_role_policy" {
  description = "Main Boundary Policy, which need to be attached to every UserManage role"
  name        = "MainBoundaryPolicy"
  path        = "/"
  policy      = templatefile("${path.module}/initial_role_policies/MainBoundary.json", {})
}

resource "aws_iam_role_policy" "tis_sub_acc_role_policy" {
  for_each = toset(var.sub_roles)
  name     = each.value
  role     = aws_iam_role.sub_acc_roles[each.value].id
  policy   = templatefile("${path.module}/role_policies/${each.value}.json", { account_id = var.account_id })
}