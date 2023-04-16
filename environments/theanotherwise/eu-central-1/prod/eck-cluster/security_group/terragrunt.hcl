include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/security_group"
}

locals {
  name = "eck-cluster"

  tags = {
    Project = "Seems Cloud (ECK Cluster)"
    Service = "Seems Cloud (ECK Cluster)"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  content = [
    {
      vpc_id  = dependency.vpc.outputs.vpc_id
      name    = "base"
      ingress = [
        {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = null
          description      = null
          security_groups  = null
          prefix_list_ids  = null
          self             = null
        }
      ]
      egress = [
        {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = null
          description      = null
          security_groups  = null
          prefix_list_ids  = null
          self             = null
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
