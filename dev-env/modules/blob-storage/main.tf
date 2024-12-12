resource "azurerm_storage_account" "storage_account" {
  name                     = "${replace(var.resource_prefix, "-", "")}sta"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "HEAD", "POST", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 86400
    }
  }
}

resource "azurerm_storage_container" "client_separated_storages" {
  for_each              = var.client_separated_storages
  name                  = "${each.value}saftstorage"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
