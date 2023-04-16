include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/network_interface"
}

locals {
  name = "bastion"

  tags = {
    Project = "Seems Cloud (Bastion)"
    Service = "Seems Cloud (Bastion)"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  content = [
    {
      vpc                = true
      subnet_id          = dependency.subnets.outputs.subnets_ids[0]
      security_group_ids = dependency.security_group.outputs.security_group_ids
    },
    {
      vpc                = true
      subnet_id          = dependency.subnets.outputs.subnets_ids[1]
      security_group_ids = dependency.security_group.outputs.security_group_ids
    },
    {
      vpc                = true
      subnet_id          = dependency.subnets.outputs.subnets_ids[2]
      security_group_ids = dependency.security_group.outputs.security_group_ids
    },
  ]
}

dependency "subnets" {
  config_path = "../subnet"

  mock_outputs = {
    subnets_ids = ["subnet"]
  }
}

dependency "security_group" {
  config_path = "../security_group"

  mock_outputs = {
    security_group_ids = ["security-group-fake"]
  }
}