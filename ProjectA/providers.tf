terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.16.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~>3.2.3"
    }
  }
}

# Provider block specifies the AzureRM provider and its specific configurations
# Different ways to authenticate
# 1. Using az cli to login => for local development
# 2. Using managed identities: use_msi = true. MSI (example when you have a Azure devops agent running in a VM, you can use maanaged idenities to allow
#    the agent to authenticate to Azure subcrption. This way you don't need to store credentials in the terraform code or environment variable.)
# 3. Use service principal
# Using environment variables to authenticate
####
# We will be using service principal to authenticate, since we're running locally for now, everything sensitive will be stored location in ENV.
###
#
# export ARM_CLIENT_ID=""
# export ARM_CLIENT_SECRET=""
# export ARM_SUBSCRIPTION_ID=""
# export ARM_TENANT_ID=""
#
provider "azurerm" {
  features {}
}