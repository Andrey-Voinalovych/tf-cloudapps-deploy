resource "azurerm_subnet" "db_sn" {
  name                 = "${var.resource_prefix}-database-subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = [var.db_subnet_cidr]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "db_dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_virt_link" {
  name                  = "${var.resource_prefix}-dns-virtual-link"
  private_dns_zone_name = azurerm_private_dns_zone.db_dns_zone.name
  virtual_network_id    = var.virtual_network.id
  resource_group_name   = var.resource_group.name
  depends_on            = [azurerm_subnet.db_sn]
}

