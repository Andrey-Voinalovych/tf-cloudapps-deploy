// Azure Environment settings

variable "deployment_environment" {
  default     = "stage"
  type        = string
  description = "Unified environment type"
}

variable "az_subscription_id" {
  type        = string
  description = "Subscription under which resources will be based"
}

variable "region" {
  default     = "North Europe"
  type        = string
  description = "Region for staging deployment"
}


// Networking

variable "virtual_network_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type = map(string)
  default = {
    "db_sn"      = "10.0.1.0/24"
    "db_gw_sn"   = "10.0.2.0/24"
    "aca_subnet" = "10.0.8.0/23"

  }
}

variable "private_dns_zone_name" {
  default     = "demo.postgres.database.azure.com"
  type        = string
  description = "Name of private DNS zone that will be used in Azure to define DB resource"
}


// Container registry settings 

variable "container_registry_settings" {
  type = object({
    sku           = string,
    admin_enabled = bool
  })
  default = {
    sku           = "Basic"
    admin_enabled = true
  }
  description = "Parameters for Azure container registry for app code deployment"
}

// LOGGING 
variable "log_retention_days" {
  default     = 30
  description = "After what amount of days - logs will be perished for container app"
}


// Container instance/environment settings 


variable "validation_service_deployment" {
  type = object({
    container_reg_name   = string
    container_image_name = string
    container_image_tag  = string
  })
  default = {
    container_reg_name   = "saftstagecr"
    container_image_name = "validation-svc"
    container_image_tag  = "latest"
  }
}

variable "decoupling_service_deployment" {
  type = object({
    container_reg_name   = string
    container_image_name = string
    container_image_tag  = string
  })
  default = {
    container_reg_name   = "saftstagecr"
    container_image_name = "decoupling-svc"
    container_image_tag  = "latest"
  }
}

variable "auth_service_deployment" {
  type = object({
    container_reg_name   = string
    container_image_name = string
    container_image_tag  = string
  })
  default = {
    container_reg_name   = "saftstagecr"
    container_image_name = "authentication-svc"
    container_image_tag  = "3e623a8"
  }
}

variable "web_frontend_deployment" {
  type = object({
    container_reg_name   = string
    container_image_name = string
    container_image_tag  = string
  })
  default = {
    container_reg_name   = "saftstagecr"
    container_image_name = "saft-front-end"
    container_image_tag  = "latest"
  }
}

variable "nginx_deployment" {
  type = object({
    container_reg_name   = string
    container_image_name = string
    container_image_tag  = string
  })
  default = {
    container_reg_name   = "saftstagecr"
    container_image_name = "nginx-web-srv"
    container_image_tag  = "init"
  }
}


// Blob storage container settings

variable "client_separated_storages" {
  default     = ["client1"]
  type        = set(string)
  description = "List of clients for which uqinue separated storages should be created"
}



// Database Variables

variable "pg_db" {
  type = map(string)
  default = {
    "name"            = "pg-dev-db"
    "pg_version"      = "16"
    "zone"            = "1"
    "storage_size_mb" = "32768"
    "storage_tier"    = "P4"
    "sku_name"        = "B_Standard_B1ms"

  }
  description = "Postgres database instance settings"
}


variable "pg_login" {
  type        = string
  description = "Login to access DB"
}

variable "pg_password" {
  type        = string
  description = "Password to DB"
  sensitive   = true
}

variable "pgadmin_login" {
  type = string
}

variable "pgadmin_password" {
  type      = string
  sensitive = true
}

variable "database_host" {
  type = string
}

// Sensitive env variables

variable "jwt_encryption_key" {
  type        = string
  sensitive   = true
  description = "Default JWT encryption token that should be used in svcs"
}
