#data "azurerm_resource_group" "rg" {
#  name = local.dev_resource_group
#}

# resource "azurerm_storage_account" "storage" {
#   name = "storageaccount"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location = "West Europe"
# }


resource "azurerm_resource_group" "rg" {
  name = local.dev_resource_group
  location = "SouthEastAsia"
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}