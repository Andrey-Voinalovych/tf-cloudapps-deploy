output "container_app_id" {
  value = azurerm_container_app.container_app.id
}

output "fqdn" {
  description = "The FQDN of the Container App's ingress."
  value       = azurerm_container_app.container_app.ingress[0].fqdn
}

output "uri" {
  description = "URI of container app"
  value       = "https://${azurerm_container_app.container_app.ingress[0].fqdn}"
}
