resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_public_ip" "vpn_gw_public_ip" {
  name                = "${var.resource_prefix}-public-ip"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = var.public_gtw_ip_alloc_method
}

resource "azurerm_virtual_network_gateway" "vpn_gtw" {
  name                = "${var.resource_prefix}-vpn-gwt"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  type                = var.vpn_gateway_configuration.type
  vpn_type            = var.vpn_gateway_configuration.vpn_type
  sku                 = var.vpn_gateway_configuration.sku
  ip_configuration {
    name                          = "${var.resource_prefix}-ip-conf"
    public_ip_address_id          = azurerm_public_ip.vpn_gw_public_ip.id
    private_ip_address_allocation = var.vpn_gateway_configuration.private_ip_address_allocation
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }

  # Client configuration for Point-to-Site VPN Gateway connections
  vpn_client_configuration {
    address_space = ["172.16.0.0/24"]
    root_certificate {
      name             = "${var.resource_prefix}-${var.root_certificate.name}"
      public_cert_data = file(var.root_certificate.path)
    }
  }

  depends_on = [
    azurerm_subnet.gateway_subnet,
    azurerm_public_ip.vpn_gw_public_ip
  ]
}

output "gtw_public_ip" {
  value = azurerm_public_ip.vpn_gw_public_ip.ip_address
}


