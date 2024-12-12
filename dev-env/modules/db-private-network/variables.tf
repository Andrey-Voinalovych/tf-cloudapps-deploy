variable "resource_prefix" {
  description = "Prefix for all resources created in module"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group object definition"

}

variable "db_subnet_cidr" {
  type        = string
  description = "CIDR of Database subnet that will be applied"
}

variable "virtual_network" {
  type = object({
    id   = string
    name = string
  })
  description = "Virtual network object definition"
}

variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
}

