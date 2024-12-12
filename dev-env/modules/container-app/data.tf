data "azurerm_container_registry" "acr" {
  name                = var.container_reg_name
  resource_group_name = var.rg_name
}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}