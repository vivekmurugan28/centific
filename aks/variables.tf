variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}

variable "aks_name" {
  type = string
}

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

variable "sku_tier" {
  type = string
}

variable "auto_scaling_enabled" {
  type = bool
}
