output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  # How to list multiple resources with count and output? 
  value = azurerm_storage_account.storage[0].name
}

output "storage_account_endpoint" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}