variable "resource_prefix" {
  description = "Prefix for all resources created in module"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR of gateway sn"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group definition object"
}

variable "virtual_network" {
  type = object({
    name     = string
    location = string
  })
  description = "Virtual network definition object"
}

variable "vpn_gateway_configuration" {
  default = {
    type                          = "Vpn"
    vpn_type                      = "RouteBased"
    sku                           = "VpnGw1"
    private_ip_address_allocation = "Dynamic"
  }
  type = object({
    type                          = string
    vpn_type                      = string
    sku                           = string
    private_ip_address_allocation = string
  })
  description = "Vpn gateway main parameters for setup the resource"
}

variable "public_gtw_ip_alloc_method" {
  default     = "Static"
  type        = string
  description = "Public gateway IP allocation method"
}

variable "root_certificate" {
  default = {
    name = "rootcert"
    path = "vpn-certificate/rootcert.cer"
  }
  type = object({
    name = string
    path = string
  })
  description = "Root certificate path to setup VPN certificates"
}

