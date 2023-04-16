include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/eks_cluster"
}

locals {
  name = "eck-cluster"

  tags = {
    Project = "Seems Cloud - ECK Cluster"
    Service = "Seems Cloud - ECK Cluster"
  }
}

inputs = {
  name = local.name
  tags = local.tags

  cluster_version         = "1.26"
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnets_ids             = dependency.subnets.outputs.subnets_ids
  security_group_ids      = dependency.security_group.outputs.security_group_ids
  endpoint_private_access = true
  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  service_ipv4_cidr       = "172.20.0.0/16"
  ip_family               = "ipv4"

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
  config_path = "../../vpc"

  mock_outputs = {
    vpc_id = "vpc-fake"
  }
}

dependency "subnets" {
  config_path = "../subnet"

  mock_outputs = {
    subnets_ids = "subnets-ids-fake"
  }
}

dependency "security_group" {
  config_path = "../security_group"

  mock_outputs = {
    security_group_ids = ["security-group-fake"]
  }
}
