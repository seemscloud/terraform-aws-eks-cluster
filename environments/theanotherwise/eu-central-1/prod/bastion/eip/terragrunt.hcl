include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/eip"
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
      vpc                  = true
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[0]
    },
    {
      vpc                  = true
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[1]
    },
    {
      vpc                  = true
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[2]
    },
  ]
}

dependency "network_interface" {
  config_path = "../network_interface"

  mock_outputs = {
    network_interface_ids = ["network-interface-fake"]
  }
}