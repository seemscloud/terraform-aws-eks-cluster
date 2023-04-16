remote_state {
  backend = "local"

  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

inputs = merge(
  local.environment_vars.inputs,
  local.region_vars.inputs,
  local.account_vars.inputs,
  {
    default_tags = merge(
      local.environment_vars.inputs.default_tags,
      local.region_vars.inputs.default_tags,
      local.account_vars.inputs.default_tags
    )
  }
)
