resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.pip_allocation_method

  tags = {
    Environment = var.environment
  }
}