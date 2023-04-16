include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/vpc"
}

locals {
  name = "seemscloud"

  tags = {
    Project = "Seems Cloud"
    Service = "Seems Cloud"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  cidr_block           = "10.255.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}
