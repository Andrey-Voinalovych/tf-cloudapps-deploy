output "client_storages" {
  value = {
    for key, container in azurerm_storage_container.client_separated_storages :
    key => {
      name = container.name
    }
  }
  description = "Details of created clients storage containers"
}
