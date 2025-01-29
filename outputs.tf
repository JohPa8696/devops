output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

// Using wild card to output storage names
//output "storage_account_name" {
//  # How to list multiple resources with count and output? 
//  value = azurerm_storage_account.storages[*].name
//}

// Using for loop, mainly used for output.
output "storage_account_name" {
  value = [for i in azurerm_storage_account.storages : i.name]
}

output "storage_account_endpoints" {
  value = [for i in azurerm_storage_account.storages : i.primary_web_endpoint]
}

output "nsg_rules" {
  value = local.nsg_rules[*]
}
