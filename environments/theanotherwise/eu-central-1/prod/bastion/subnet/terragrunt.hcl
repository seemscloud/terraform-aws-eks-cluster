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
      vpc_id     = dependency.vpc.outputs.vpc_id
      cidr_block = "10.255.255.0/28"
      zone       = "eu-central-1a"
    },
    {
      vpc_id     = dependency.vpc.outputs.vpc_id
      cidr_block = "10.255.255.16/28"
      zone       = "eu-central-1b"
    },
    {
      vpc_id     = dependency.vpc.outputs.vpc_id
      cidr_block = "10.255.255.32/28"
      zone       = "eu-central-1c"
    }
  ]
}

dependency "vpc" {
  config_path = "../../vpc"

  mock_outputs = {
    vpc_id = "vpc-fake"
  }
}