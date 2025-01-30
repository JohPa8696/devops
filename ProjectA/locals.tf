locals {
  shared_rg_name = "${var.environment}-shared-rg"

  current_time = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  tags = {
    environment = var.environment
    owner = "DevOps"
  }
}


// Tracking changes for the resource
locals {
  vnet_config = {
    name                = "${var.environment}-vnet"
    location            = var.location
    resource_group_name = azurerm_resource_group.shared_rg.name
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
  }
  vnet_hash = sha1(jsonencode(local.vnet_config))
}