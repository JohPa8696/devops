# Terraform block specifies the required providers and their versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # The source is Hashicorp, meaning the provider is maintained by Hashicorp
      version = "~> 4.16.0"         # It's better to lock the version to a specific version, because of potential breaking changes
    }                               # ~> only allow the rightmost to increment.
  }

  required_version = ">=1.0.0"
}

# Provider block specifies the AzureRM provider and its specific configurations
provider "azurerm" {
  features {}
  use_cli = true
}

