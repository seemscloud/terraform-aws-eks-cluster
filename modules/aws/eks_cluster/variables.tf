variable "aws_region_name" {
  type = string
}

# Resource
variable "name" {
  type    = string
  default = "default"
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets_ids" {
  type = list(string)
}

variable "assume_role_policy" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "public_access_cidrs" {
  type = list(string)
}

# Tags
variable "tags" {
  type = map(string)
}

variable "default_tags" {
  type = map(string)
}