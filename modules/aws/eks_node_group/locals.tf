locals {
  eks_node_policies = [
    "AmazonEC2ContainerRegistryReadOnly",
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy"
  ]
}