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

resource "azurerm_network_security_group" "private_subnet_nsg" {
  name                = "${var.environment}-private-subnet-nsg"
  location            = azurerm_resource_group.shared_rg.location
  resource_group_name = azurerm_resource_group.shared_rg.name


  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = local.tags
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_subnet_nsg.id
}