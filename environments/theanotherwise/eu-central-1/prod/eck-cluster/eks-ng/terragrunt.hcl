#include {
#  path = find_in_parent_folders()
#}
#
#terraform {
#  source = "${get_parent_terragrunt_dir()}/..//modules/aws/eks-ng"
#}
#
#locals {
#  name = "eck-lorem-ng-alpha"
#
#  tags = {
#    Project = "Lorem Ipsum"
#    Service = "Lorem Ipsum"
#  }
#}
#
#inputs = {
#  name = local.name
#  tags = local.tags
#
#  eks_id      = dependency.eks.outputs.eks_id
#  subnets_ids = dependency.subnets.outputs.subnets_ids
#
#  scaling_config = {
#    desired_size = 1
#    max_size     = 1
#    min_size     = 1
#  }
#
#  instance_types = ["c5d.xlarge"]
#
#  assume_role_policy = <<EOF
#{
# "Version": "2012-10-17",
# "Statement": [
#  {
#   "Effect": "Allow",
#   "Principal": {
#    "Service": "ec2.amazonaws.com"
#   },
#   "Action": "sts:AssumeRole"
#  }
# ]
#}
#EOF
#}
#
#dependency "vpc" {
#  config_path = "../vpc"
#
#  mock_outputs = {
#    vpc_id = "vpc-fake"
#  }
#}
#
#dependency "eks" {
#  config_path = "../eks"
#
#  mock_outputs = {
#    eks_id = "eks-id-fake"
#  }
#}
#
#dependency "subnets" {
#  config_path = "../subnets"
#
#  mock_outputs = {
#    subnets_ids = "subnets-ids-fake"
#  }
#}