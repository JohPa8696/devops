locals {
  dev_resource_group = "rg-int-dev-loyalty-misc"
  common_tags = {
    client      = "internal"
    environment = "dev"
    project     = "loyalty"
    service     = "misc"
  }
}

locals {
  nsg_rules = {
    "allow_http" = {
      priority               = 100
      destination_port_range = "80"
      description            = "Allow HTTP"
    },
    "allow_https" = {
      priority               = 101
      destination_port_range = "443"
      description            = "Allow HTTPS"
    }
  }
}