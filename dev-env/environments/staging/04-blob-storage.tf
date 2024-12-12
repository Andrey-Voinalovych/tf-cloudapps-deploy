module "storage" {
  source                    = "../../modules/blob-storage"
  rg_name                   = azurerm_resource_group.stage_resource_group.name
  resource_prefix           = local.resource_prefix
  client_separated_storages = var.client_separated_storages
}
