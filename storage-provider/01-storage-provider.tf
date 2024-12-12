resource "azurerm_resource_group" "tfstate" {
  name     = "${local.resource_prefix_tfstate}-resource-group"
  location = var.region
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "${local.resource_prefix_tfstate}storage"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate_containers" {
  for_each              = toset(var.state_storage_containers)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "resource_group_name" {
  value       = azurerm_resource_group.tfstate.name
  description = "Name of resourse group that is created to store tfstate file"
}

output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "Name of created storage account"
}

output "storage_container_details" {
  value = {
    for key, container in azurerm_storage_container.tfstate_containers :
    key => {
      name = container.name
    }
  }
  description = "Details of created storage containers"
}
