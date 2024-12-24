resource "azurerm_postgresql_flexible_server" "psql" {
  name                         = var.psql_name
  resource_group_name          = var.rg_name
  location                     = var.location
  administrator_login          = var.psql_administrator_login
  administrator_password       = var.psql_administrator_login_password
  sku_name                     = var.psql_sku_name
  version                      = var.psql_version
  storage_mb                   = var.psql_storage_mb
  backup_retention_days        = var.psql_backup_retention_days
  geo_redundant_backup_enabled = var.psql_geo_redundant_backup_enabled
  auto_grow_enabled            = var.psql_auto_grow_enabled
  zone                         = var.psql_zone

  tags = {
    Environment = var.environment
  }
}
