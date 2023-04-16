resource "aws_network_interface" "network_interface" {
  count = length(var.content)

  subnet_id = var.content[count.index].subnet_id

  security_groups = var.content[count.index].security_group_ids

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )
}