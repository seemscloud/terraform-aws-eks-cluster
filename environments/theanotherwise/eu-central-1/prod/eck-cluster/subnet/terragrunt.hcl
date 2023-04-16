include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/subnet"
}

locals {
  name = "eck-cluster"

  tags = {
    Project = "ECK Cluster"
    Service = "ECK Cluster"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  content = [
    {
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.10.0/24"
      zone                    = "eu-central-1a"
      map_public_ip_on_launch = true
    },
    {
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.11.0/24"
      zone                    = "eu-central-1b"
      map_public_ip_on_launch = true
    },
    {
      vpc_id                  = dependency.vpc.outputs.vpc_id
      cidr_block              = "10.255.12.0/24"
      zone                    = "eu-central-1c"
      map_public_ip_on_launch = true
    }
  ]
}

dependency "vpc" {
  config_path = "../../vpc"

  mock_outputs = {
    vpc_id = "vpc-fake"
  }
}
