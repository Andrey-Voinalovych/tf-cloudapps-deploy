output "resource_group_name" {
  value       = azurerm_resource_group.tfstate.name
  description = "Name of resourse group that is created to store tfstate file"
}

output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "Name of created storage account"
}

output "storage_container_details" {
  value = {
    for key, container in azurerm_storage_container.tfstate_containers :
    key => {
      name = container.name
    }
  }
  description = "Details of created storage containers"
}
