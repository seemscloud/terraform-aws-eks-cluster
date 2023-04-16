locals {
  aws_account_name = "theanotherwise"
}

inputs = {
  aws_account_name = local.aws_account_name
  default_tags     = {
    Account = local.aws_account_name
  }
}
