terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace_name
  }
}
