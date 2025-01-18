resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "SouthEastAsia"
}

resource "azurerm_storage_account" "storage" {
  depends_on               = [azurerm_resource_group.rg]
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "SouthEastAsia"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_endpoint" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}