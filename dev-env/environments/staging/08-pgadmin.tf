resource "azurerm_container_app" "pgadmin" {
  name                         = "${local.resource_prefix}-pgadmin"
  resource_group_name          = azurerm_resource_group.stage_resource_group.name
  container_app_environment_id = azurerm_container_app_environment.ca_env.id
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  ingress {
    external_enabled = true
    target_port      = 9000
    transport        = "auto"
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }


  template {
    container {
      name   = "pgadmin"
      image  = "dpage/pgadmin4:latest"
      cpu    = 0.5
      memory = "1Gi"
      env {
        name  = "PGADMIN_LISTEN_PORT"
        value = 9000
      }
      env {
        name  = "PGADMIN_DEFAULT_EMAIL"
        value = var.pgadmin_login
      }

      env {
        name  = "PGADMIN_DEFAULT_PASSWORD"
        value = var.pgadmin_password
      }

      env {
        name  = "DATABASE_HOST"
        value = azurerm_postgresql_flexible_server.dev_db_instance.fqdn
      }

      env {
        name  = "DATABASE_PORT"
        value = "5432"
      }

      env {
        name  = "DATABASE_USER"
        value = var.pg_login
      }

      env {
        name  = "DATABASE_PASSWORD"
        value = var.pg_password
      }

    }

    min_replicas = 0
    max_replicas = 1
  }
}
