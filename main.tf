provider "helm" {
  alias = "aks"
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  alias                  = "aks"
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

data "azurerm_client_config" "current" {}

module "rg" {
  source   = "./rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source        = "./network/vnet"
  rg_name       = module.rg.rg_name
  vnet_name     = "Loop-${var.environment}-VNET"
  location      = var.location
  environment   = var.environment
  address_space = var.vnet_address_space
}

module "private_subnet" {
  source         = "./network/subnet"
  rg_name        = module.rg.rg_name
  vnet_name      = module.vnet.vnet_name
  subnet_name    = "Private-subnet"
  environment    = var.environment
  subnet_address = var.private_subnet_address_space
}

module "public_subnet" {
  source         = "./network/subnet"
  rg_name        = module.rg.rg_name
  vnet_name      = module.vnet.vnet_name
  subnet_name    = "Public-subnet"
  environment    = var.environment
  subnet_address = var.public_subnet_address_space
}

module "aks_subnet" {
  source         = "./network/subnet"
  rg_name        = module.rg.rg_name
  vnet_name      = module.vnet.vnet_name
  subnet_name    = "Public-subnet-aks"
  environment    = var.environment
  subnet_address = var.aks_subnet_address_space
}

module "aks" {
  source                           = "./aks"
  rg_name                          = module.rg.rg_name
  location                         = var.location
  environment                      = var.environment
  aks_name                         = "Loop2-${var.environment}-AKS-01"
  vnet_subnet_id                   = module.aks_subnet.subnet_id
  default_node_pool_node_count     = var.default_node_pool_node_count
  default_node_pool_node_max_count = var.default_node_pool_node_max_count
  default_node_pool_node_min_count = var.default_node_pool_node_min_count
  default_node_pool_vm_size        = var.default_node_pool_vm_size
  kubernetes_version               = var.kubernetes_version
  sku_tier                         = var.aks_sku_tier
  auto_scaling_enabled             = var.default_node_pool_auto_scaling_enabled
}

module "nodepool" {
  source               = "./aks_nodepool"
  aks_id               = module.aks.aks_id
  vnet_subnet_id       = module.aks_subnet.subnet_id
  node_pool_name       = "loop${var.environment}"
  vm_size              = var.node_pool_vm_size
  auto_scaling_enabled = var.node_pool_auto_scaling_enabled
  node_count           = var.node_pool_node_count
  max_count            = var.node_pool_node_max_count
  min_count            = var.node_pool_node_min_count
}

module "pip_ingress" {
  source                = "./pip"
  rg_name               = module.aks.aks_rg
  location              = var.location
  environment           = var.environment
  pip_name              = "Loop2-${var.environment}-aks-pip"
  pip_allocation_method = "Static"
}

module "k8_namespace" {
  depends_on = [module.aks]
  source     = "./k8_namespace"
  providers = {
    kubernetes = kubernetes.aks
  }
  namespace_name = "loop2-${var.environment}"
}

module "k8_namespace2" {
  depends_on = [module.aks]
  source     = "./k8_namespace"
  providers = {
    kubernetes = kubernetes.aks
  }
  namespace_name = "loop2-${var.environment}-ns"
}

module "k8_tls_secret" {
  source = "./k8_tls_secret"
  providers = {
    kubernetes = kubernetes.aks
  }
  secret_name = "loop2-${var.environment}-secret"
  namespace   = module.k8_namespace.namespace_name
  tlscrt      = var.tlscrt
  tlskey      = var.tlskey
}

module "ingress" {
  source = "./ingress"
  providers = {
    helm = helm.aks
  }
  ingress_class = "nginx"
  ingress_name  = "ingress-nginx"
  namespace     = "ingress-nginx"
  replica_count = 2
  pip_ip        = module.pip_ingress.pip_ip
  certificate   = "${module.k8_namespace.namespace_name}/${module.k8_tls_secret.secret_name}"
}

module "cosmosdb" {
  source                 = "./cosmosdb_account"
  rg_name                = module.rg.rg_name
  location               = var.location
  cosmosdb_name          = "loop2-${var.environment}-cosmos"
  environment            = var.environment
  consistency_level      = var.cosmos_consistency_level
  failover_priority      = var.cosmos_failover_priority
  geo_location           = var.location
  offer_type             = "Standard"
  total_throughput_limit = var.cosmos_total_throughput_limit
}

module "storage_account_registered" {
  source                           = "./storage_account"
  rg_name                          = module.rg.rg_name
  location                         = var.location
  storage_account_name             = "loop2${var.environment}registered"
  environment                      = var.environment
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
}

module "storage_account_public" {
  source                           = "./storage_account"
  rg_name                          = module.rg.rg_name
  location                         = var.location
  storage_account_name             = "loop2${var.environment}public"
  environment                      = var.environment
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
}

module "storage_account_temp" {
  source                           = "./storage_account"
  rg_name                          = module.rg.rg_name
  location                         = var.location
  storage_account_name             = "loop2${var.environment}temp"
  environment                      = var.environment
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
}

module "postgresql" {
  source                            = "./psql_server"
  rg_name                           = module.rg.rg_name
  location                          = var.location
  psql_name                         = "loop2-${var.environment}-postgres"
  environment                       = var.environment
  psql_administrator_login          = var.psql_administrator_login
  psql_administrator_login_password = var.psql_administrator_login_password
  psql_sku_name                     = var.psql_sku_name
  psql_version                      = var.psql_version
  psql_storage_mb                   = var.psql_storage_mb
  psql_auto_grow_enabled            = var.psql_auto_grow_enabled
  psql_backup_retention_days        = var.psql_backup_retention_days
  psql_geo_redundant_backup_enabled = var.psql_geo_redundant_backup_enabled
  psql_zone                         = var.psql_zone
}

module "psql_db" {
  source         = "./psql_db"
  psql_db_name   = "${var.environment}loopdb"
  psql_server_id = module.postgresql.psql_id
}

module "keyvault" {
  source        = "./keyvault"
  rg_name       = module.rg.rg_name
  location      = var.location
  keyvault_name = "loop2-${var.environment}-keyvault"
  environment   = var.environment
  sku_name      = var.keyvault_sku_name
}

module "kv_access_policy_tf_account" {
  source             = "./keyvault_access_policy"
  kv_id              = module.keyvault.keyvault_id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  key_permissions    = ["Get", "Create", "Delete", "List", "Update", "Import", "Encrypt", "Decrypt", "Backup", "Recover", "Purge", "Restore"]
  secret_permissions = ["Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"]
}

module "kv_psql_connection_string" {
  depends_on   = [module.kv_access_policy_tf_account]
  source       = "./keyvault_secret"
  kv_id        = module.keyvault.keyvault_id
  secret_name  = "psqldbconnectionstring"
  secret_value = "Server=loop2-${var.environment}-postgres.postgres.database.azure.com;Database=loop;Port=5432;User Id=${var.psql_administrator_login};Password=${var.psql_administrator_login_password};Ssl Mode=Require;"
}

module "apim" {
  source          = "./apim"
  rg_name         = module.rg.rg_name
  location        = var.location
  apim_name       = "loop-${var.environment}-apim"
  publisher_name  = var.apim_publisher_name
  publisher_email = var.apim_publisher_email
  sku_name        = var.apim_sku_name
  environment     = var.environment
}

# module "acr_aks_integration" {
#   source = "./ara"
#   principal_id = module.aks.kubelet_identity
#   scope = module.acr.acr_id
#   role_definition_name = "AcrPull"
#   skip_service_principal_aad_check = true
# }
