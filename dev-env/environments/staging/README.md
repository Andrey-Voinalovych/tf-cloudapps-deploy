## Auto-Updated on Thu Dec 12 15:02:00 UTC 2024

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_authentication_svc"></a> [authentication\_svc](#module\_authentication\_svc) | ../../modules/container-app | n/a |
| <a name="module_decoupling_svc"></a> [decoupling\_svc](#module\_decoupling\_svc) | ../../modules/container-app | n/a |
| <a name="module_front_end"></a> [front\_end](#module\_front\_end) | ../../modules/container-app | n/a |
| <a name="module_nginx"></a> [nginx](#module\_nginx) | ../../modules/container-app | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/blob-storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app.pgadmin](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/container_app) | resource |
| [azurerm_container_app_environment.ca_env](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/container_app_environment) | resource |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/container_registry) | resource |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.jwt_encryption_key](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log_an](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_postgresql_flexible_server.dev_db_instance](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_resource_group.stage_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.vn](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/4.1.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_subscription_id"></a> [az\_subscription\_id](#input\_az\_subscription\_id) | Subscription under which resources will be based | `string` | n/a | yes |
| <a name="input_client_separated_storages"></a> [client\_separated\_storages](#input\_client\_separated\_storages) | List of clients for which uqinue separated storages should be created | `set(string)` | <pre>[<br/>  "client1"<br/>]</pre> | no |
| <a name="input_container_registry_settings"></a> [container\_registry\_settings](#input\_container\_registry\_settings) | Parameters for Azure container registry for app code deployment | <pre>object({<br/>    sku           = string,<br/>    admin_enabled = bool<br/>  })</pre> | <pre>{<br/>  "admin_enabled": true,<br/>  "sku": "Basic"<br/>}</pre> | no |
| <a name="input_database_host"></a> [database\_host](#input\_database\_host) | n/a | `string` | n/a | yes |
| <a name="input_deployment_environment"></a> [deployment\_environment](#input\_deployment\_environment) | Unified environment type to use as prefix | `string` | `"stage"` | no |
| <a name="input_jwt_encryption_key"></a> [jwt\_encryption\_key](#input\_jwt\_encryption\_key) | Default JWT encryption token that should be used in svcs | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | After what amount of days - logs will be perished for container app | `number` | `30` | no |
| <a name="input_pg_db"></a> [pg\_db](#input\_pg\_db) | Postgres database instance settings | `map(string)` | <pre>{<br/>  "name": "pg-dev-db",<br/>  "pg_version": "16",<br/>  "sku_name": "B_Standard_B1ms",<br/>  "storage_size_mb": "32768",<br/>  "storage_tier": "P4",<br/>  "zone": "1"<br/>}</pre> | no |
| <a name="input_pg_login"></a> [pg\_login](#input\_pg\_login) | Login to access DB | `string` | n/a | yes |
| <a name="input_pg_password"></a> [pg\_password](#input\_pg\_password) | Password to DB | `string` | n/a | yes |
| <a name="input_pgadmin_login"></a> [pgadmin\_login](#input\_pgadmin\_login) | n/a | `string` | n/a | yes |
| <a name="input_pgadmin_password"></a> [pgadmin\_password](#input\_pgadmin\_password) | n/a | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Name of private DNS zone that will be used in Azure to define DB resource | `string` | `"demo.postgres.database.azure.com"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for staging deployment | `string` | `"North Europe"` | no |
| <a name="input_services_deployment_images"></a> [services\_deployment\_images](#input\_services\_deployment\_images) | Container instances settings | <pre>map(object({<br/>    name = string<br/>    tag  = string<br/>  }))</pre> | <pre>{<br/>  "auth_service": {<br/>    "name": "authentication-svc",<br/>    "tag": "3e623a8"<br/>  },<br/>  "decoupling_service": {<br/>    "name": "decoupling-svc",<br/>    "tag": "latest"<br/>  },<br/>  "nginx": {<br/>    "name": "nginx-web-srv",<br/>    "tag": "init"<br/>  },<br/>  "validation_service": {<br/>    "name": "validation-svc",<br/>    "tag": "latest"<br/>  },<br/>  "web_frontend": {<br/>    "name": "saft-front-end",<br/>    "tag": "latest"<br/>  }<br/>}</pre> | no |
| <a name="input_subnet_cidrs"></a> [subnet\_cidrs](#input\_subnet\_cidrs) | n/a | `map(string)` | <pre>{<br/>  "aca_subnet": "10.0.8.0/23",<br/>  "db_gw_sn": "10.0.2.0/24",<br/>  "db_sn": "10.0.1.0/24"<br/>}</pre> | no |
| <a name="input_virtual_network_cidr"></a> [virtual\_network\_cidr](#input\_virtual\_network\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_frontend_uri"></a> [frontend\_uri](#output\_frontend\_uri) | URI of of the frontend deployed pod |
<!-- END_TF_DOCS -->