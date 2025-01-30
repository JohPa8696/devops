resource "null_resource" "vnet_tracker" {
  triggers = {
    config_hash = local.vnet_hash
  }

  lifecycle {
    ignore_changes = [triggers]
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_config.name
  location            = local.vnet_config.location
  resource_group_name = local.vnet_config.resource_group_name
  address_space       = local.vnet_config.address_space
  dns_servers         = local.vnet_config.dns_servers

  tags = merge(local.tags, {
    modified_time = null_resource.vnet_tracker.id != null ? timestamp() : null
  })
}


