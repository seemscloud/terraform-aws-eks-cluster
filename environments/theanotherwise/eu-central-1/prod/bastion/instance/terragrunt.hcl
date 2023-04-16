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
      ami                  = "ami-0ec7f9846da6b0f61"
      instance_type        = "t3.micro"
      security_group_ids   = dependency.security_group.outputs.security_group_ids
      key_name             = dependency.key_pair.outputs.key_pair_names[0]
      subnet_id            = dependency.subnets.outputs.subnets_ids[0]
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[0]
    },
    {
      ami                  = "ami-0ec7f9846da6b0f61"
      instance_type        = "t3.micro"
      security_group_ids   = dependency.security_group.outputs.security_group_ids
      key_name             = dependency.key_pair.outputs.key_pair_names[0]
      subnet_id            = dependency.subnets.outputs.subnets_ids[1]
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[1]
    },
    {
      ami                  = "ami-0ec7f9846da6b0f61"
      instance_type        = "t3.micro"
      security_group_ids   = dependency.security_group.outputs.security_group_ids
      key_name             = dependency.key_pair.outputs.key_pair_names[0]
      subnet_id            = dependency.subnets.outputs.subnets_ids[2]
      network_interface_id = dependency.network_interface.outputs.network_interface_ids[2]
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

dependency "key_pair" {
  config_path = "../../key_pair"

  mock_outputs = {
    key_pair_names = "key-pair-names-fake"
  }
}

dependency "network_interface" {
  config_path = "../network_interface"

  mock_outputs = {
    network_interface_ids = ["network-interface-fake"]
  }
}