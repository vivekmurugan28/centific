resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.aks_name
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool {
    name                        = "system"
    node_count                  = var.default_node_pool_node_count
    max_count                   = var.default_node_pool_node_max_count
    min_count                   = var.default_node_pool_node_min_count
    vm_size                     = var.default_node_pool_vm_size
    vnet_subnet_id              = var.vnet_subnet_id
    temporary_name_for_rotation = "tmpnp"
    auto_scaling_enabled        = var.auto_scaling_enabled
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
    tags = {
      Environment = var.environment
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku   = "standard"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "calico"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  web_app_routing {
    dns_zone_ids = []
  }

  tags = {
    Environment = var.environment
  }
}
