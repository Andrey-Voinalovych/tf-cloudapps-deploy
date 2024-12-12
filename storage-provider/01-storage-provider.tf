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
