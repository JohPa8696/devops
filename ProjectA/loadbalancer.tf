# Public IP for the load balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.environment}-lb-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  allocation_method   = "Static" # Required for Standard SKU
  sku                 = "Standard"
  tags                = local.tags
}

# Load Balancer
resource "azurerm_lb" "vmss_lb" {
  name                = "${var.environment}-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }

  tags = local.tags
}


# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "vmss_pool" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "VMSSPool"
}

# Health Probe
resource "azurerm_lb_probe" "vmss_probe" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "http-probe"
  protocol        = "Http" # or "Tcp" depending on your needs
  port            = 80     # Your application port
  request_path    = "/"    # Health check endpoint
}


# Load Balancing Rule
resource "azurerm_lb_rule" "vmss_rule" {
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.vmss_pool.id]
  probe_id                       = azurerm_lb_probe.vmss_probe.id
  enable_floating_ip             = false
}