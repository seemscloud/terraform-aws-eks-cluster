variable "aws_region_name" {
  type = string
}

# Resource
variable "name" {
  type    = string
  default = "default"
}

variable "content" {
  type = list(object({
    vpc                = bool
    subnet_id          = string
    security_group_ids = list(string)
  }))
}

# Tags
variable "tags" {
  type = map(string)
}

variable "default_tags" {
  type = map(string)
}