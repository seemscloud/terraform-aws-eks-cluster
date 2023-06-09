include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/subnet"
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
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.255.0/28"
      zone                    = "eu-central-1a"
      map_public_ip_on_launch = false
    },
    {
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.255.16/28"
      zone                    = "eu-central-1b"
      map_public_ip_on_launch = false
    },
    {
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.255.32/28"
      zone                    = "eu-central-1c"
      map_public_ip_on_launch = false
    }
  ]
}

dependency "vpc" {
  config_path = "../../vpc"

  mock_outputs = {
    vpc_id = "vpc-fake"
  }
}