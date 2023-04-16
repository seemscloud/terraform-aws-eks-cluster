resource "aws_security_group" "security_group" {
  # for_each = {for i, v in var.content :  i => v}
  count = length(var.content)

  name    = "${var.name}-${var.content[count.index].name}"
  vpc_id  = var.content[count.index].vpc_id
  ingress = var.content[count.index].ingress
  egress  = var.content[count.index].egress

  tags = merge(
    { "Name" : "${var.name}-${var.content[count.index].name}" },
    var.tags,
    var.default_tags
  )
}