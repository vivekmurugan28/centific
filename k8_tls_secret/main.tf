terraform {
  required_providers {
    kubectl = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_secret" "secret" {
   metadata {
     name = var.secret_name
     namespace = var.namespace
   }
   type = "kubernetes.io/tls"
   data = {
     "tls.crt" = file(var.tlscrt)
     "tls.key" = file(var.tlskey)
   }
 }
