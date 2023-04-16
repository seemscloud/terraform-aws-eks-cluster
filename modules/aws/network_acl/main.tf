resource "aws_network_acl" "network_acl" {
  for_each = {for i, v in var.content :  i => v}

  vpc_id     = each.value.vpc_id
  subnet_ids = each.value.subnets_ids
  ingress    = each.value.ingress
  egress     = each.value.egress

  tags = merge(
    { "Name" : "${var.name}-${each.value.name}" },
    var.tags,
    var.default_tags
  )
}