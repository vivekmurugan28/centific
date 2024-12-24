output "cosmosdb_id" {
  value = azurerm_cosmosdb_account.cosmosdb.id
}

output "cosmosdb_name" {
  value = azurerm_cosmosdb_account.cosmosdb.name
}

output "cosmosdb_primary_sql_connection_string" {
  value = azurerm_cosmosdb_account.cosmosdb.primary_sql_connection_string
}
