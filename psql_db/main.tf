resource "azurerm_postgresql_flexible_server_database" "psql_db" {
  name      = var.psql_db_name
  server_id = var.psql_server_id

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
