variable "resource_prefix" {
  description = "Prefix for all resources created in module"
}

variable "deployed_app_name" {
  description = "Application name that will be deployed under container"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
}

variable "container_reg_name" {
  default     = "saftbackenddev"
  description = "Name of container registry with app repo"
  type        = string
}

variable "container_environment_id" {
  type        = string
  description = "CE where service is deployed"
}

// CONTAINER IMAGE UNDER REGISTRY
variable "container_image_name" {
  description = "The name of the container image to deploy"
  type        = string
}

variable "container_image_tag" {
  default     = "latest"
  description = "The tag of the container image to deploy"
  type        = string
}

// REPLICATION SETTINGS

variable "min_replicas_amount" {
  default     = 0
  description = "Min number of container replicas that will be created"
  type        = string
}

variable "max_replicas_amount" {
  default     = 1
  description = "Max number of container replicas that will be created"
  type        = string
}

variable "liveness_probe" {
  type = object({
    failure_count_threshold = number
    initial_delay           = number
    path                    = string
    port                    = number
    transport               = string
  })
  description = "Liveness probe for application"
}

variable "ingress" {
  type = object({
    external_enabled = bool
    transport        = string
    target_port      = number
  })

}

variable "environment_vars" {
  type = list(object({
    name        = string
    secret_name = optional(string)
    value       = optional(string)
  }))
  default = []
}

variable "compute_resources" {
  type = object({
    cpu    = number
    memory = string
  })

  default = {
    cpu    = 0.25
    memory = "0.5Gi"
  }
}
