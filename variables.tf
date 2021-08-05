variable "iam_groups_acc_map" {
  description = "Map of IAM groups and in which AWS accounts they can ASSSUME Roles"
  default = {
    "CloudOps"    = ["131845455848"]
    "Developers"  = ["131845455848"]
  }
}