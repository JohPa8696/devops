resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.allowed_locations[3]
  tags     = var.resource_tags
}
