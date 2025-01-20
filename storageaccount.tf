resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.allowed_locations[3]
  tags     = var.resource_tags
}


resource "azurerm_storage_account" "storages" {
  for_each   = var.storage_account_names
  count      = length(var.storage_account_names) // better to use set instead of list, because list has duplicate values. 
  depends_on = [azurerm_resource_group.rg]
  // name                  = var.storage_account_names[count.index] // only for count meta argument
  name                     = each.value
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.allowed_locations[3]
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.resource_tags
}



// Foreach can only works with map, object, set. because it can't work with a list with duplicate values.check "name" {


