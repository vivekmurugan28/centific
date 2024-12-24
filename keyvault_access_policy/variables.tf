variable "kv_id" {
  type = string
}

variable "key_permissions" {
  type = list(string)
}

variable "secret_permissions" {
  type = list(string)
}

variable "tenant_id" {
  type = string
}

variable "object_id" {
  type = string
}
