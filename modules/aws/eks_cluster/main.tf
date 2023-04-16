resource "aws_eks_cluster" "eks_cluster" {
  name     = var.name
  role_arn = aws_iam_role.iam_role.arn

  vpc_config {
    subnet_ids              = var.subnets_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = var.security_group_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
    ip_family         = var.ip_family
  }

  version = var.cluster_version

  depends_on = [
    aws_iam_role.iam_role
  ]

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.default_tags
  )
}

resource "aws_iam_role" "iam_role" {
  name = var.name

  assume_role_policy = var.assume_role_policy

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.default_tags
  )
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role.id

  depends_on = [
    aws_iam_role.iam_role
  ]
}
