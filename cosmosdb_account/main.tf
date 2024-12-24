resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.rg_name
  offer_type          = var.offer_type

  consistency_policy {
    consistency_level = var.consistency_level
  }

  capacity {
    total_throughput_limit = var.total_throughput_limit
  }

  geo_location {
    location          = var.geo_location
    failover_priority = var.failover_priority
  }

  tags = {
    Environment = var.environment
  }
}
