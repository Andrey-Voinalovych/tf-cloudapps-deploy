variable "resource_prefix" {
  description = "Prefix for all resources created in module"
}

variable "region" {
  type        = string
  description = "Region for staging deployment"
}

variable "virtual_network_cidr" {
  type        = string
  description = "Virtual network CIDR"
}
