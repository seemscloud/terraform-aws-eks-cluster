resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support



  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_vpc.vpc
  ]
}


resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress = []
  egress  = []

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_vpc.vpc
  ]
}
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  lifecycle {
    ignore_changes = [
      subnet_ids
    ]
  }

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_default_route_table" "default_network_acl" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_default_vpc_dhcp_options" "default_vpc_dhcp_options" {
  tags = merge(
    { "Name" : var.name },
    var.tags,
    var.default_tags
  )

  depends_on = [
    aws_vpc.vpc
  ]
}