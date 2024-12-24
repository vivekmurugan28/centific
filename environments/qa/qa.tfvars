rg_name     = "Loop2.0-QA"
location    = "eastus"
environment = "qa"

#VNET, SUBNET
vnet_address_space           = ["192.169.0.0/16"]
private_subnet_address_space = ["192.169.0.0/24"]
public_subnet_address_space  = ["192.169.1.0/24"]
aks_subnet_address_space     = ["192.169.2.0/24"]

#AKS
kubernetes_version                     = "1.29.10"
default_node_pool_vm_size              = "Standard_D4ds_v5"
default_node_pool_node_count           = 2
default_node_pool_node_max_count       = 5
default_node_pool_node_min_count       = 2
default_node_pool_auto_scaling_enabled = true
aks_sku_tier                           = "Free"

#AKS NODEPOOL
node_pool_vm_size              = "Standard_D4s_v3"
node_pool_node_count           = 4
node_pool_node_max_count       = 10
node_pool_node_min_count       = 4
node_pool_auto_scaling_enabled = true

#COSMOS
cosmos_total_throughput_limit = 4000
cosmos_consistency_level      = "Session"
cosmos_failover_priority      = 0

#STORAGE ACCOUNT
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"

#POSTGRESQL
psql_sku_name                     = "B_Standard_B1ms"
psql_version                      = "16"
psql_storage_mb                   = 32768
psql_backup_retention_days        = 7
psql_geo_redundant_backup_enabled = false
psql_auto_grow_enabled            = false
psql_zone                         = 2

#KEYVAULT
keyvault_sku_name = "standard"

#APIM
apim_publisher_name  = "Centific"
apim_publisher_email = "marko.milicevic@centific.com"
apim_sku_name        = "Developer_1"
