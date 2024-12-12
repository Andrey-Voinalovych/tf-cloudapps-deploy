resource "azurerm_log_analytics_workspace" "log_an" {
  name                = "${local.resource_prefix}-log-analytics"
  location            = azurerm_resource_group.stage_resource_group.location
  resource_group_name = azurerm_resource_group.stage_resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
}

resource "azurerm_container_app_environment" "ca_env" {
  name                       = "${local.resource_prefix}-container-env"
  location                   = azurerm_resource_group.stage_resource_group.location
  resource_group_name        = azurerm_resource_group.stage_resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_an.id
}


# module "validation_svc" {
#   source                             = "../../modules/container-app"
#   resource_prefix                    = local.resource_prefix
#   rg_name                            = azurerm_resource_group.stage_resource_group.name
#   container_reg_name                 = var.validation_service_deployment.container_reg_name
#   container_image_name               = var.validation_service_deployment.container_image_name
#   container_image_tag                = var.validation_service_deployment.container_image_tag
#   deployed_app_name                  = "validations"
#   container_environment_id           = azurerm_container_app_environment.ca_env.id
#   containerapp_identity_id           = azurerm_user_assigned_identity.containerapp_identity.id
#   containerapp_identity_principal_id = azurerm_user_assigned_identity.containerapp_identity.principal_id

#   liveness_probe = {
#     failure_count_threshold = 3
#     initial_delay           = 10
#     path                    = "/LivenessCheck/check"
#     port                    = 8080
#     transport               = "HTTP"
#   }
# }

module "authentication_svc" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = var.auth_service_deployment.container_reg_name
  container_image_name     = var.auth_service_deployment.container_image_name
  container_image_tag      = var.auth_service_deployment.container_image_tag
  deployed_app_name        = "authentication"
  container_environment_id = azurerm_container_app_environment.ca_env.id

  liveness_probe = {
    failure_count_threshold = 3
    initial_delay           = 10
    path                    = "/LivenessCheck/check"
    port                    = 8080
    transport               = "HTTP"
  }

  ingress = {
    external_enabled = true
    transport        = "http"
    target_port      = 8080
  }

  environment_vars = [{
    name  = "DB_CONNECTION_STRING"
    value = var.db_connection_string
    }, {
    name  = "JWT_TOKEN_KEY"
    value = var.jwt_encryption_key
  }]
}

module "decoupling_svc" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = var.decoupling_service_deployment.container_reg_name
  container_image_name     = var.decoupling_service_deployment.container_image_name
  container_image_tag      = var.decoupling_service_deployment.container_image_tag
  deployed_app_name        = "decoupling"
  container_environment_id = azurerm_container_app_environment.ca_env.id

  liveness_probe = {
    failure_count_threshold = 3
    initial_delay           = 10
    path                    = "/LivenessCheck/check"
    port                    = 8080
    transport               = "HTTP"
  }

  ingress = {
    external_enabled = true
    transport        = "http"
    target_port      = 8080
  }

  compute_resources = {
    cpu    = 2
    memory = "4Gi"
  }
  environment_vars = [{
    name  = "DB_CONNECTION_STRING"
    value = var.db_connection_string
    }, {
    name  = "JWT_TOKEN_KEY"
    value = var.jwt_encryption_key
  }]
}

module "front_end_node" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = var.web_frontend_deployment.container_reg_name
  container_image_name     = var.web_frontend_deployment.container_image_name
  container_image_tag      = var.web_frontend_deployment.container_image_tag
  deployed_app_name        = "webfrontend"
  container_environment_id = azurerm_container_app_environment.ca_env.id

  compute_resources = {
    cpu    = 2
    memory = "4Gi"
  }

  ingress = {
    external_enabled = true
    transport        = "http"
    target_port      = 3000
  }

  liveness_probe = {
    failure_count_threshold = 3
    initial_delay           = 10
    path                    = "/"
    port                    = 3000
    transport               = "HTTP"
  }

}

output "frontend_uri" {
  value       = module.front_end_node.uri
  description = "URI of frontend container app"
}


module "nginx" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = var.web_frontend_deployment.container_reg_name
  container_image_name     = var.web_frontend_deployment.container_image_name
  container_image_tag      = var.web_frontend_deployment.container_image_tag
  deployed_app_name        = "nginx-webserver"
  container_environment_id = azurerm_container_app_environment.ca_env.id

  ingress = {
    external_enabled = true
    transport        = "http"
    target_port      = 80
  }

  liveness_probe = {
    failure_count_threshold = 3
    initial_delay           = 10
    path                    = "/"
    port                    = 80
    transport               = "HTTP"
  }

}
