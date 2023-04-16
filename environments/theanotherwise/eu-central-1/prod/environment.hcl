locals {
  environment_name = "prod"
}

inputs = {
  environment_name = local.environment_name
  default_tags     = {
    Environment = local.environment_name
  }
}