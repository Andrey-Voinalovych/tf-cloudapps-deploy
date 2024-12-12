output "subnet_id" {
  value = azurerm_subnet.db_sn.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.db_dns_zone.id
}
