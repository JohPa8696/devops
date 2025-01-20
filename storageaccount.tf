resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.allowed_locations[3]
  tags     = var.resource_tags
}

resource "azurerm_storage_account" "storages" {
  count = length(var.storage_account_names)
  depends_on               = [azurerm_resource_group.rg]
  name                     = var.storage_account_names[count.index]
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.allowed_locations[3]
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.resource_tags
}