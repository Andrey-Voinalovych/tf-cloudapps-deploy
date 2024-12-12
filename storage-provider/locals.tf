locals {
  resource_prefix_tfstate = "safttfstate${lower(var.deployment_environment)}"

  resource_prefix_cr = "saftbackend${lower(var.deployment_environment)}"

  acr_sp_name = "saft-sp-ghactions-${lower(var.deployment_environment)}"
}
