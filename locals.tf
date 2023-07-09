locals {
  hugo = {
    name       = "hugo"
    image_name = "nivleshc/hugo:nivleshcwordpress_0.1"

    replica_count = 2

    service = {
      port             = 80
      target_port      = 80
      session_affinity = "ClientIP"
      type             = "NodePort"
    }

    ingress = {
      annotations = {
        scheme      = "internet-facing"
        target_type = "instance"
      }
      class_name = "alb"
      rule = {
        http = {
          path = {
            path      = "/"
            path_type = "Prefix"
          }
        }
      }
    }
  }
}