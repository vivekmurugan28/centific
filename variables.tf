variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

#VNET, SUBNET

variable "vnet_address_space" {
  type = list(any)
}

variable "public_subnet_address_space" {
  type = list(any)
}

variable "private_subnet_address_space" {
  type = list(any)
}

variable "aks_subnet_address_space" {
  type = list(any)
}

#AKS
variable "kubernetes_version" {
  type = string
}

variable "default_node_pool_vm_size" {
  type = string
}

variable "default_node_pool_node_count" {
  type = number
}

variable "default_node_pool_node_max_count" {
  type = number
}

variable "default_node_pool_node_min_count" {
  type = number
}

variable "aks_sku_tier" {
  type = string
}

variable "default_node_pool_auto_scaling_enabled" {
  type = bool
}

variable "node_pool_vm_size" {
  type = string
}

variable "node_pool_node_count" {
  type = number
}

variable "node_pool_node_max_count" {
  type = number
}

variable "node_pool_node_min_count" {
  type = number
}

variable "node_pool_auto_scaling_enabled" {
  type = bool
}

#K8 Secret

variable "tlscrt" {
  type = string
}

variable "tlskey" {
  type = string
}

#Cosmos
variable "cosmos_total_throughput_limit" {
  type = number
}

variable "cosmos_consistency_level" {
  type = string
}

variable "cosmos_failover_priority" {
  type = number
}

#Storage Account

variable "storage_account_tier" {
  type = string
}

variable "storage_account_replication_type" {
  type = string
}

#PostgreSQL

variable "psql_administrator_login" {
  type = string
}

variable "psql_administrator_login_password" {
  type = string
}

variable "psql_sku_name" {
  type = string
}

variable "psql_version" {
  type = string
}

variable "psql_storage_mb" {
  type = number
}

variable "psql_backup_retention_days" {
  type = number
}

variable "psql_geo_redundant_backup_enabled" {
  type = bool
}

variable "psql_auto_grow_enabled" {
  type = bool
}

variable "psql_zone" {
  type = number
}

#Keyvault

variable "keyvault_sku_name" {
  type = string
}

#APIM

variable "apim_publisher_name" {
  type = string
}

variable "apim_publisher_email" {
  type = string
}

variable "apim_sku_name" {
  type = string
}
