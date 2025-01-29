variable "resource_group_name" {
  type    = string
  default = "rg"
}

variable "storage_account_names" {
  type    = set(string)
  default = ["sa1", "sa2"]
}

variable "sa_location" {
  type    = string
  default = "SouthEast Asia"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "disk_size_gb" {
  type    = number
  default = 80
}

variable "is_delete_os_disk_on_termination" {
  type    = bool
  default = true
}

variable "is_delete_data_disks_on_termination" {
  type    = bool
  default = true
}

variable "allowed_locations" {
  type    = list(string)
  default = ["West Europe", "East US", "West US", "SouthEast Asia"]
}

variable "resource_tags" {
  type = map(string)
  default = {
    client      = "internal"
    environment = "dev"
    project     = "loyalty"
    service     = "misc"
  }
}

variable "network_config" {
  # type = object({
  #   address_space = string
  #   subnet_prefixes = list(string)
  # })
  type    = tuple([string, string])
  default = ["10.0.0.0/16", "10.0.2.0/24"]
}