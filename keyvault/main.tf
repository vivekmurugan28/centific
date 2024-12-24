resource "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  tags = {
    Environment = var.environment
  }
}

# Data source to fetch the current tenant ID
data "azurerm_client_config" "current" {}
