resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.iam_role.arn
  subnet_ids      = var.subnets_ids

  scaling_config {
    desired_size = var.scaling_config.desired_size
    max_size     = var.scaling_config.max_size
    min_size     = var.scaling_config.min_size
  }

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size

  tags = merge(
    { "Name" = var.node_group_name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_iam_role.iam_role,
    aws_iam_role_policy_attachment.role_policy_attachment
  ]
}

resource "aws_iam_role" "iam_role" {
  name = var.node_group_name

  assume_role_policy = var.assume_role_policy



  tags = merge(
    { "Name" = var.node_group_name },
    var.tags,
    var.default_tags
  )
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  for_each   = toset(local.eks_node_policies)
  role       = aws_iam_role.iam_role.id
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"


  depends_on = [
    aws_iam_role.iam_role
  ]
}
