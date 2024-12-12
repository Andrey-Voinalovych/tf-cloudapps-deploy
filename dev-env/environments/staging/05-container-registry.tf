resource "azurerm_container_registry" "container_registry" {
  name                = "${local.resource_prefix}cr"
  resource_group_name = azurerm_resource_group.stage_resource_group.name
  location            = azurerm_resource_group.stage_resource_group.location
  sku                 = var.container_registry_settings.sku
  admin_enabled       = var.container_registry_settings.admin_enabled
}
