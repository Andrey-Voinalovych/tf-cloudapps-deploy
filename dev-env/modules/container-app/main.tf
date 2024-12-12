resource "azurerm_user_assigned_identity" "containerapp_identity" {
  location            = data.azurerm_resource_group.rg.location
  name                = "${var.resource_prefix}-${var.deployed_app_name}-identity"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "containerapp" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.containerapp_identity.principal_id
}

resource "azurerm_container_app" "container_app" {
  name                         = "${var.resource_prefix}-${var.deployed_app_name}-app"
  container_app_environment_id = var.container_environment_id
  resource_group_name          = data.azurerm_resource_group.rg.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.containerapp_identity.id]
  }

  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.containerapp_identity.id
  }

  template {
    container {
      name   = "${var.deployed_app_name}-app"
      image  = "${data.azurerm_container_registry.acr.login_server}/${var.container_image_name}:${var.container_image_tag}"
      cpu    = var.compute_resources.cpu
      memory = var.compute_resources.memory

      dynamic "env" {
        for_each = var.environment_vars == null ? [] : var.environment_vars

        content {
          name        = env.value.name
          secret_name = env.value.secret_name
          value       = env.value.value
        }
      }

      liveness_probe {
        failure_count_threshold = var.liveness_probe.failure_count_threshold
        initial_delay           = var.liveness_probe.initial_delay
        path                    = var.liveness_probe.path
        port                    = var.liveness_probe.port
        transport               = var.liveness_probe.transport
      }
    }
    min_replicas = var.min_replicas_amount
    max_replicas = var.max_replicas_amount
  }

  ingress {
    external_enabled = var.ingress.external_enabled
    transport        = var.ingress.transport
    target_port      = var.ingress.target_port
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  depends_on = [azurerm_role_assignment.containerapp]

  lifecycle {
    ignore_changes = [
      template[0].container[0].image
    ]
  }
}
