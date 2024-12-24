variable "vnet_subnet_id" {
  type = string
}

variable "aks_id" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "node_count" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "max_count" {
  type = number
}

variable "min_count" {
  type = number
}

variable "auto_scaling_enabled" {
  type = bool
}
