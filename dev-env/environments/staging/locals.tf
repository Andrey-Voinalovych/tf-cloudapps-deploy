locals {
  resource_prefix = "saft${var.deployment_environment}"

  db_connection_string = format(
    "Host=%s;Port=%d;Username=%s;Password=%s;Database=%s;SslMode=Require;Trust Server Certificate=true",
    azurerm_postgresql_flexible_server.dev_db_instance.fqdn,
    5432, // Default PostgreSQL port
    var.pg_login,
    var.pg_password,
    azurerm_postgresql_flexible_server.dev_db_instance.name
  )
}
