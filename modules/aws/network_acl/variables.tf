variable "aws_region_name" {
  type = string
}

# Resource
variable "name" {
  type    = string
  default = "default"
}

variable "content" {
  type = list(
    object({
      vpc_id      = string
      subnets_ids = list(string)
      name        = string
      ingress     = list(object({
        protocol        = string
        action          = string
        rule_no         = number
        cidr_block      = string
        from_port       = number
        to_port         = number
        icmp_code       = number
        icmp_type       = number
        ipv6_cidr_block = string
      }))
      egress = list(object({
        protocol        = string
        action          = string
        rule_no         = number
        cidr_block      = string
        from_port       = number
        to_port         = number
        icmp_code       = number
        icmp_type       = number
        ipv6_cidr_block = string
      }))
    })
  )
}

# Tags
variable "tags" {
  type = map(string)
}

variable "default_tags" {
  type = map(string)
}