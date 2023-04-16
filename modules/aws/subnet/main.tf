resource "aws_subnet" "subnet" {
  count                   = length(var.content)
  vpc_id                  = var.content[count.index].vpc_id
  cidr_block              = var.content[count.index].cidr_block
  availability_zone       = var.content[count.index].zone
  map_public_ip_on_launch = var.content[count.index].map_public_ip_on_launch

  tags = merge(
    { "Name" : "${var.name}-${count.index}" },
    var.tags,
    var.default_tags
  )
}