resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.environment}-vmss"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  sku                 = lookup(var.allowed_vm_size, var.environment, "Standard_B1s")
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/vmss_id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.private_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.vmss_pool.id]
    }
  }

  tags = local.tags
}


# Monitor autoscale setting
resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = "${var.environment}-vmss-autoscale"
  resource_group_name = azurerm_resource_group.shared_rg.name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "AutoScale"

    capacity {
      default = 2
      minimum = 1
      maximum = 5
    }

    # Scale out rule (add instances)
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M" # 1 minute
        statistic          = "Average"
        time_window        = "PT5M" # 5 minutes
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 80 # Scale out when CPU > 80%
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M" # Wait 5 minutes before next scale action
      }
    }

    # Scale in rule (remove instances)
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 10 # Scale in when CPU < 10%
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
  # notification {
  #   email {
  #     send_to_subscription_administrator    = true
  #     send_to_subscription_co_administrator = true
  #   }
  # }
}
