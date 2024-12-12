resource "azurerm_resource_group" "dev_rg" {
  name     = "${var.resource_prefix}-resourse_group"
  location = var.region
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.resource_prefix}-virtual-network"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  address_space       = [var.virtual_network_cidr]
}

