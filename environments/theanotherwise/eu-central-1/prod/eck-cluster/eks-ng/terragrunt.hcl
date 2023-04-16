include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/aws/eks_node_group"
}

locals {
  name = "eck-cluster-ng-alpha"

  tags = {
    Project = "Lorem Ipsum"
    Service = "Lorem Ipsum"
  }
}

inputs = {
  node_group_name = local.name
  tags            = local.tags

  cluster_name = dependency.eks.outputs.cluster_name
  subnets_ids  = dependency.subnets.outputs.subnets_ids

  scaling_config = {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["c5d.xlarge"]
  capacity_type  = "SPOT"
  disk_size      = 20

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
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

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    cluster_name = "cluster-name-fake"
  }
}

dependency "subnets" {
  config_path = "../subnet"

  mock_outputs = {
    subnets_ids = "subnets-ids-fake"
  }
}