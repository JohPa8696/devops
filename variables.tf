variable "resource_group_name" {
  type = string
  default = "rg"
}

variable "storage_account_name" {
  type = string
  default = "sa"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "disk_size_gb" {
  type = number
  default = 80
}

variable "is_delete_os_disk_on_termination" {
  type = bool
  default = true
}

variable "is_delete_data_disks_on_termination" {
  type = bool
  default = true
}

variable "allowed_locations" {
  type = list(string)
  default = ["West Europe", "East US", "West US", "SouthEastAsia"]
}
