resource "azurerm_postgresql_flexible_server" "dev_db_instance" {
  name                          = var.pg_db.name
  resource_group_name           = azurerm_resource_group.stage_resource_group.name
  location                      = azurerm_resource_group.stage_resource_group.location
  version                       = var.pg_db.pg_version
  public_network_access_enabled = true
  administrator_login           = var.pg_login
  administrator_password        = var.pg_password
  zone                          = var.pg_db.zone

  storage_mb   = var.pg_db.storage_size_mb
  storage_tier = var.pg_db.storage_tier

  sku_name = var.pg_db.sku_name
}

