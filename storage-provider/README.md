## Auto-Updated on Wed Nov 27 09:10:07 UTC 2024 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.tfstate_containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_environment"></a> [deployment\_environment](#input\_deployment\_environment) | Unified environment type | `string` | `"DEV"` | no |
| <a name="input_region"></a> [region](#input\_region) | Azure region in which storage will be created | `string` | `"North Europe"` | no |
| <a name="input_state_storage_containers"></a> [state\_storage\_containers](#input\_state\_storage\_containers) | Storage container names that will be created to store tfstate files for different configurations | `list(string)` | <pre>[<br/>  "stage",<br/>  "prod"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of resourse group that is created to store tfstate file |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Name of created storage account |
| <a name="output_storage_container_details"></a> [storage\_container\_details](#output\_storage\_container\_details) | Details of created storage containers |
<!-- END_TF_DOCS -->
