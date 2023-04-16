include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/instance"
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
      ami       = "ami-0ec7f9846da6b0f61"
      subnet_id = dependency.subnets.outputs.subnets_ids[0]
    },
    {
      ami       = "ami-0ec7f9846da6b0f61"
      subnet_id = dependency.subnets.outputs.subnets_ids[1]
    },
    {
      ami       = "ami-0ec7f9846da6b0f61"
      subnet_id = dependency.subnets.outputs.subnets_ids[2]
    },
  ]
}

dependency "subnets" {
  config_path = "../subnet"

  mock_outputs = {
    subnets_ids = ["subnet"]
  }
}