// Container Apps Environment resources
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

// Container Apps Deployment
module "authentication_svc" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = azurerm_container_registry.container_registry.name
  container_image_name     = var.services_deployment_images["auth_service"].name
  container_image_tag      = var.services_deployment_images["auth_service"].tag
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
    value = local.db_connection_string
    }, {
    name        = "JWT_TOKEN_KEY"
    secret_name = azurerm_key_vault_secret.jwt_encryption_key.name
  }]
}

module "decoupling_svc" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = azurerm_container_registry.container_registry.name
  container_image_name     = var.services_deployment_images["decoupling_service"].name
  container_image_tag      = var.services_deployment_images["decoupling_service"].tag
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
    value = local.db_connection_string
    }, {
    name        = "JWT_TOKEN_KEY"
    secret_name = azurerm_key_vault_secret.jwt_encryption_key.name
  }]
}

module "front_end" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = azurerm_container_registry.container_registry.name
  container_image_name     = var.services_deployment_images["web_frontend"].name
  container_image_tag      = var.services_deployment_images["web_frontend"].tag
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


module "nginx" {
  source                   = "../../modules/container-app"
  resource_prefix          = local.resource_prefix
  rg_name                  = azurerm_resource_group.stage_resource_group.name
  container_reg_name       = azurerm_container_registry.container_registry.name
  container_image_name     = var.services_deployment_images["nginx"].name
  container_image_tag      = var.services_deployment_images["nginx"].tag
  deployed_app_name        = "webserver"
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
