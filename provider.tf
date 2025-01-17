# Terraform block specifies the required providers and their versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # The source is Hashicorp, meaning the provider is maintained by Hashicorp
      version = "~> 4.16.0"         # It's better to lock the version to a specific version, because of potential breaking changes
    }                               # ~> only allow the rightmost to increment.
  }

  backend "azurerm" {
    resource_group_name  = "terraform-management-rg"
    storage_account_name = "jpnztfsa"
    container_name      = "tfstate"
    key                = "terraform.tfstate"
  }

  required_version = ">=1.0.0"
}

# Provider block specifies the AzureRM provider and its specific configurations
provider "azurerm" {
  features {}
  # Different ways to authenticate
  # 1. Using az cli to login => for local development
  # 2. Using managed identities: use_msi = true. MSI (example when you have a Azure devops agent running in a VM, you can use maanaged idenities to allow
  #    the agent to authenticate to Azure subcrption. This way you don't need to store credentials in the terraform code or environment variable.)
  # 3. Use service principal
  # Using environment variables to authenticate
}

