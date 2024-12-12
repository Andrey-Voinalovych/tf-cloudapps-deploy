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

# data "azurerm_storage_account_blob_container_sas" "rawd_sas" {
#   for_each          = azurerm_storage_container.client_separated_storages
#   connection_string = azurerm_storage_account.storage_account.primary_connection_string
#   container_name    = each.value.name
#   https_only        = true

#   ip_address = "168.1.5.65"

#   start  = "2024-11-01"
#   expiry = "2026-11-01"

#   permissions {
#     read   = true
#     add    = true
#     create = false
#     write  = true
#     delete = true
#     list   = true
#   }

#   cache_control       = "max-age=5"
#   content_disposition = "inline"
#   content_encoding    = "deflate"
#   content_language    = "en-US"
#   content_type        = "application/json"
# }

# output "sas_urls" {
#   value = {
#     for key, sas in data.azurerm_storage_account_blob_container_sas.rawd_sas : key => sas.sas
#   }
# }
