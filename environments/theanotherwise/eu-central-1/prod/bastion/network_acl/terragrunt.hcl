include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/network_acl"
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
      name        = "base"
      vpc_id      = dependency.vpc.outputs.vpc_id
      subnets_ids = dependency.subnets.outputs.subnets_ids
      ingress     = [
        {
          protocol        = "tcp"
          rule_no         = 100
          action          = "allow"
          cidr_block      = "0.0.0.0/0"
          from_port       = 22
          to_port         = 22
          icmp_code       = null
          icmp_type       = null
          ipv6_cidr_block = null
        }
      ]
      egress = [
        {
          protocol        = "-1"
          rule_no         = 100
          action          = "allow"
          cidr_block      = "0.0.0.0/0"
          from_port       = 0
          to_port         = 0
          icmp_code       = null
          icmp_type       = null
          ipv6_cidr_block = null
        }
      ]
    }
  ]
}

dependency "vpc" {
  config_path = "../../vpc"

  mock_outputs = {
    vpc_id = "vpc-fake"
  }
}

dependency "subnets" {
  config_path = "../subnet"

  mock_outputs = {
    subnets_ids = ["subnet-fake"]
  }
}