variable "aws_region_name" {
  type = string
}

# Resource
variable "name" {
  type    = string
  default = "default"
}

variable "cidr_block" {
  type    = string
  default = "default"
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

# Tags
variable "tags" {
  type = map(string)
}

variable "default_tags" {
  type = map(string)
}