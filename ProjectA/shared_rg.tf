resource "azurerm_resource_group" "shared_rg" {
  name     = local.shared_rg_name
  location = var.location
  tags = local.tags

  lifecycle {
    precondition {
      condition = var.environment == "dev"
      error_message = "This resource group can only be deleted in the dev environment"
    }

    precondition {
      condition = var.location == "southeastasia"
      error_message = "This resource group can only be created in the southeastasia location"
    }
  }
}