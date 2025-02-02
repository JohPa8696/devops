variable "environment" {
  type        = string
  description = "The environment to deploy to"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Invalid environment. Please use 'dev', 'stage', or 'prod'."
  }
}

variable "location" {
  type        = string
  description = "The location to deploy to"
  default     = "southeastasia"
  validation {
    condition = contains([
      "eastus", "eastus2", "westus", "westus2", "westus3",
      "centralus", "northcentralus", "southcentralus",
      "westeurope", "northeurope",
      "uksouth", "ukwest",
      "eastasia", "southeastasia"
    ], var.location)
    error_message = "Invalid location. Please choose from the allowed regions"
  }
}

variable "security_rules" {
  type        = list(any)
  description = "The security rules to apply to the NSG"
}


variable "allowed_vm_size" {
  type        = map(string)
  description = "The size of the VM to deploy"
  default     = {
    "dev" = "Standard_B2s"
    "stage" = "Standard_B2s"
    "prod" = "Standard_B2s"
  }
  validation {
    condition = contains(keys(var.allowed_vm_size), var.environment)
    error_message = "Invalid environment. Please use 'dev', 'stage', or 'prod'."
  }
}
