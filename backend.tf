terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-management-rg"
    storage_account_name = "jpnztfsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}