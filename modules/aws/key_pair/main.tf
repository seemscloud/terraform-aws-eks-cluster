resource "aws_key_pair" "deployer" {
  count = length(var.content)

  key_name   = "${var.name}-${var.content[count.index].name}"
  public_key = var.content[count.index].public_key

  tags = merge(
    { "Name" : "${var.name}-${var.content[count.index].name}" },
    var.tags,
    var.default_tags
  )
}