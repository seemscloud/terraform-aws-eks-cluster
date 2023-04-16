locals {
  aws_region_name = "eu-central-1"
}

inputs = {
  aws_region_name = local.aws_region_name
  default_tags    = {
    Region = local.aws_region_name
  }
}