resource "azurerm_virtual_network" "vn" {
  name                = "${local.resource_prefix}-vn"
  location            = azurerm_resource_group.stage_resource_group.location
  resource_group_name = azurerm_resource_group.stage_resource_group.name
  address_space       = [var.virtual_network_cidr]
}

// Database network
# resource "azurerm_subnet" "db_sn" {
#   name                 = "${local.resource_prefix}-db-sn"
#   resource_group_name  = azurerm_resource_group.stage_resource_group.name
#   virtual_network_name = azurerm_virtual_network.vn.name
#   address_prefixes     = [var.subnet_cidrs.db_sn]
#   service_endpoints    = ["Microsoft.Storage"]
#   delegation {
#     name = "fs"
#     service_delegation {
#       name = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#       ]
#     }
#   }
#   private_endpoint_network_policies = "Enabled"
# }

# resource "azurerm_private_dns_zone" "db_dns_zone" {
#   name                = var.private_dns_zone_name
#   resource_group_name = azurerm_resource_group.stage_resource_group.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "dns_virt_link" {
#   name                  = "${local.resource_prefix}-dns-virtl"
#   private_dns_zone_name = azurerm_private_dns_zone.db_dns_zone.name
#   virtual_network_id    = azurerm_virtual_network.vn.id
#   resource_group_name   = azurerm_resource_group.stage_resource_group.name
#   depends_on            = [azurerm_subnet.db_sn]
# }

# resource "azurerm_private_dns_a_record" "pgadmin_dns_record" {
#   name                = "${local.resource_prefix}-pgadmin-app"
#   zone_name           = azurerm_private_dns_zone.db_dns_zone.name
#   resource_group_name = azurerm_resource_group.stage_resource_group.name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.container_app_endpoint.]
# }
