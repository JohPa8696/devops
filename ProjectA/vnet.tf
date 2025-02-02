resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = local.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "${var.environment}-private-subnet"
  resource_group_name  = azurerm_resource_group.shared_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}