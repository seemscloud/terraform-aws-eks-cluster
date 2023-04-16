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
      vpc_id  = string
      name    = string
      ingress = list(object({
        protocol         = string
        cidr_blocks      = list(string)
        from_port        = number
        to_port          = number
        ipv6_cidr_blocks = list(string)
        description      = string
        security_groups  = list(string)
        prefix_list_ids  = list(string)
        self             = string
      }))
      egress = list(object({
        protocol         = string
        cidr_blocks      = list(string)
        from_port        = number
        to_port          = number
        ipv6_cidr_blocks = list(string)
        description      = string
        security_groups  = list(string)
        prefix_list_ids  = list(string)
        self             = string
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