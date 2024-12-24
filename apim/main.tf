resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  tags = {
    Environment = var.environment
  }

  timeouts {
    create = "2h"
    update = "2h"
    delete = "1h"
  }
}