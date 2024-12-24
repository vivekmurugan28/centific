terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}
resource "helm_release" "ingress-nginx" {
  name             = var.ingress_name
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.11.3"

  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_class
  }
  set {
    name  = "controller.ingressClass"
    value = var.ingress_class
  }
  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = "k8s.io/${var.ingress_class}"
  }
  set {
    name  = "controller.service.loadBalancerIP"
    value = var.pip_ip
  }
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }
  set {
    name  = "controller.extraArgs.default-ssl-certificate"
    value = var.certificate
  }
}
