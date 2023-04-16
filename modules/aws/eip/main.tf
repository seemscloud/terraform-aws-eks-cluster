resource "aws_eip" "eip" {
  count = length(var.content)

  vpc               = var.content[count.index].vpc
  network_interface = var.content[count.index].network_interface_id

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )
}