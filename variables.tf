variable "master_acc_id" {
  description = "The ID of the master AWS acc"
  type = "string"
  default = "131845455848"
}

/*
For the example we have only ONE AWS account that is why - same value
*/
variable "account_id" {
  description = "The ID of the sub AWS acc"
  type = "string"
  default = "131845455848"
}

variable "iam_groups_acc_map" {
  description = "Map of IAM groups and in which AWS accounts they can ASSSUME Roles"
  default = {
    "CloudOps"    = ["131845455848"]
    "Developers"  = ["131845455848"]
  }
}

variable "sub_roles" {
    description = "List of roles to be created in the AWS acc"
    type = "list"
    default = ["DevOps", "Developers"]
}