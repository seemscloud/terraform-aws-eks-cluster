resource "aws_instance" "instance" {
  for_each = {for i, v in var.content :  i => v}

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  network_interface {
    device_index         = 0
    network_interface_id = each.value.network_interface_id
  }

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )
}