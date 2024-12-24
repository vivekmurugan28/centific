variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "psql_name" {
  type = string
}

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
