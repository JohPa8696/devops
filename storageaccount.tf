resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.allowed_locations[3]
  tags     = local.common_tags
}

resource "azurerm_storage_account" "storage" {
  depends_on               = [azurerm_resource_group.rg]
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.allowed_locations[3]
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}