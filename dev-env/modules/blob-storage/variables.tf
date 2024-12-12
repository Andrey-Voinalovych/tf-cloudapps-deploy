variable "resource_prefix" {
  description = "Prefix for all resources created in module"
}

variable "rg_name" {
  description = "Resource group name"
}

variable "client_separated_storages" {
  type        = set(string)
  description = "List of clients for which uqinue separated storages should be created"
}
