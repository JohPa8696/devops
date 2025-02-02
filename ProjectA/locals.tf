locals {
  shared_rg_name = "${var.environment}-shared-rg"

  current_time = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  tags = {
    environment   = var.environment
    owner         = "DevOps"
    creation_time = local.current_time
  }
}
