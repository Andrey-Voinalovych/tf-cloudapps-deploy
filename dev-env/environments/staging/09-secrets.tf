data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
  name                       = "${local.resource_prefix}keyvault"
  location                   = azurerm_resource_group.stage_resource_group.location
  resource_group_name        = azurerm_resource_group.stage_resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "db_connection_string" {
  name         = "db-connection-string"
  value        = var.db_connection_string
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "jwt_encryption_key" {
  name         = "jwt-encryption-key"
  value        = var.jwt_encryption_key
  key_vault_id = azurerm_key_vault.keyvault.id
}
