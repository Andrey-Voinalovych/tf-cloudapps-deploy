
// Azure Environment settings
variable "deployment_environment" {
  default     = "DEV"
  type        = string
  description = "Unified environment type"
}

variable "region" {
  default     = "North Europe"
  type        = string
  description = "Azure region in which storage will be created"
}


// Tfstate container settings
variable "state_storage_containers" {
  default     = ["stage", "prod"]
  type        = list(string)
  description = "Storage container names that will be created to store tfstate files for different configurations"
}
