resource "aws_instance" "web" {
  for_each      = {for i, v in var.content :  i => v}
  ami           = each.value.ami
  instance_type = "t3.micro"

  subnet_id = each.value.subnet_id

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )
}