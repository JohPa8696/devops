output "shared_rg_id" {
  value = azurerm_resource_group.shared_rg.id
}


output "nsg_rules" {
  value = var.security_rules[*]
}