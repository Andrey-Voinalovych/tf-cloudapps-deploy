// Legacy VPN for services VN from local machines using generated root certificate 
# module "vpn_gwt" {
#   source          = "../../modules/vpn-gtw"
#   resource_prefix = local.resource_prefix
#   resource_group  = azurerm_resource_group.stage_resource_group
#   virtual_network = azurerm_virtual_network.vn
#   subnet_cidr     = var.subnet_cidrs.db_gw_sn
#   root_certificate = {
#     name = "rootcert"
#     path = "vpn-certificate/rootcert.cer"
#   }
# }
