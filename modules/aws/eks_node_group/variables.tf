variable "aws_region_name" {
  type = string
}

# Resource
variable "node_group_name" {
  type    = string
  default = "default"
}

variable "cluster_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "subnets_ids" {
  type = list(string)
}

# Tags
variable "tags" {
  type = map(string)
}

variable "default_tags" {
  type = map(string)
}