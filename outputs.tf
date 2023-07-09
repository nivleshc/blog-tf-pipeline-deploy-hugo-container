output "hugo_service_ingress_http_hostname" {
  description = "Hugo service ingress hostname"
  value       = kubernetes_ingress_v1.hugo.status[0].load_balancer[0].ingress[0].hostname
}