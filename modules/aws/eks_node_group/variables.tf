variable "aws_region_name" {
  type = string
}

# Resource
variable "name" {
  type    = string
  default = "default"
}

variable "eks_id" {
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