resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.allowed_locations[3]
  tags     = var.resource_tags
}


resource "azurerm_storage_account" "storages" {
  for_each = var.storage_account_names
  // count      = length(var.storage_account_names) // better to use set instead of list, because list has duplicate values. 
  depends_on = [azurerm_resource_group.rg]

  // name                  = var.storage_account_names[count.index] // only for count meta argument
  name                     = each.value
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.sa_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.resource_tags

  lifecycle {
    create_before_destroy = true                           // Can use this to make sure there is no down time on the resource
    ignore_changes        = [tags, account_tier, location] // Use this to make sure changes to the atribute are ignored.
    replace_triggered_by  = [azurerm_resource_group.rg]    // Whenever the resource group changes, this resource will be replaced.postcondition
    prevent_destroy       = false                           // Enforce rule to never distroy the condition.
    precondition {
      condition     = contains(var.allowed_locations, var.sa_location)
      error_message = "Please make sure the locaiton is valid"
    } // before the resource can be provisioned, this block checka list of conditions before provisioning the resource.

    // postcondition { } // After the resource is provisoned, we can put in condition to make sure the resource was provisioned correctly,
  }
}


// Foreach can only works with map, object, set. because it can't work with a list with duplicate values.check "name" {


