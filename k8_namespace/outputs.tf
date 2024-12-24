output "namespace_id" {
  value = kubernetes_namespace.namespace.id
}

output "namespace_name" {
  value       = kubernetes_namespace.namespace.metadata[0].name
}
