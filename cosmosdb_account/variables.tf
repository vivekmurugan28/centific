variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "cosmosdb_name" {
  type = string
}

variable "offer_type" {
  type = string
}

variable "consistency_level" {
  type = string
}

variable "failover_priority" {
  type = number
}

variable "geo_location" {
  type = string
}

variable "total_throughput_limit" {
  type = number
}
