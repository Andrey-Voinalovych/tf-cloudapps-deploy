resource "azurerm_resource_group" "stage_resource_group" {
  name     = "${local.resource_prefix}rg"
  location = var.region
}
