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
      vpc_id     = string
      cidr_block = string
      zone       = string
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