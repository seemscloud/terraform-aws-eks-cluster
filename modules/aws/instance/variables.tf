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
      ami                  = string
      instance_type        = string
      key_name             = string
      network_interface_id = string
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