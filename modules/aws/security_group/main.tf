resource "aws_security_group" "security_group" {
  for_each = {for i, v in var.content :  i => v}

  name    = "${var.name}-${each.value.name}"
  vpc_id  = each.value.vpc_id
  ingress = each.value.ingress
  egress  = each.value.egress

  tags = merge(
    { "Name" : "${var.name}-${each.value.name}" },
    var.tags,
    var.default_tags
  )
}