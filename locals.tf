locals {
  dev_resource_group = "rg-int-dev-loyalty-misc"
  common_tags =  {
    client = "internal"
    environment = "dev"
    project = "loyalty"
    service = "misc"
  }
}