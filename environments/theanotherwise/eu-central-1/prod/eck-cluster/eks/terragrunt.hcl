include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/eks"
}

locals {
  name = "eks-lorem"

  tags = {
    Project = "Lorem Ipsum"
    Service = "Lorem Ipsum"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  cluster_version         = "1.26"
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnets_ids             = dependency.subnets.outputs.subnets_ids
  endpoint_private_access = false
  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "vpc-id-fake"
    sg_id  = "sg-id-fake"
  }
}

dependency "subnets" {
  config_path = "../subnets"

  mock_outputs = {
    subnets_ids = "subnets-ids-fake"
  }
}