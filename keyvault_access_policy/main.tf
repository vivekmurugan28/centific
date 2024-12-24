resource "azurerm_key_vault_access_policy" "kv_policy" {
  key_vault_id       = var.kv_id
  tenant_id          = var.tenant_id
  object_id          = var.object_id
  key_permissions    = var.key_permissions
  secret_permissions = var.secret_permissions
}
