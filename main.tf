resource "kubernetes_namespace" "hugo" {
  metadata {
    name = "${var.env}-${local.hugo.name}"
  }
}

resource "kubernetes_deployment" "hugo" {
  metadata {
    name = "${var.env}-${local.hugo.name}-deployment"
    labels = {
      app = "${var.env}-${local.hugo.name}"
    }
    namespace = kubernetes_namespace.hugo.id
  }

  spec {
    replicas = local.hugo.replica_count

    selector {
      match_labels = {
        app = "${var.env}-${local.hugo.name}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.env}-${local.hugo.name}"
        }
      }

      spec {
        container {
          image = local.hugo.image_name
          name  = local.hugo.name
        }
      }
    }
  }
}

resource "kubernetes_service" "hugo" {
  metadata {
    name      = "${var.env}-${local.hugo.name}-service"
    namespace = kubernetes_namespace.hugo.id
  }

  spec {
    selector = {
      app = kubernetes_deployment.hugo.spec[0].template[0].metadata[0].labels.app
    }

    session_affinity = local.hugo.service.session_affinity
    port {
      port        = local.hugo.service.port
      target_port = local.hugo.service.target_port
    }

    type = local.hugo.service.type
  }
}

resource "kubernetes_ingress_v1" "hugo" {
  metadata {
    name      = local.hugo.name
    namespace = kubernetes_namespace.hugo.id
    annotations = {

      "alb.ingress.kubernetes.io/scheme"      = local.hugo.ingress.annotations.scheme
      "alb.ingress.kubernetes.io/target-type" = local.hugo.ingress.annotations.target_type
    }
    labels = {
      "app.kubernetes.io/name" = local.hugo.name
    }
  }
  spec {
    ingress_class_name = local.hugo.ingress.class_name
    rule {
      http {
        path {
          path = local.hugo.ingress.rule.http.path.path
          backend {
            service {
              name = kubernetes_service.hugo.metadata[0].name
              port {
                number = local.hugo.service.port
              }
            }
          }
          path_type = local.hugo.ingress.rule.http.path.path_type
        }
      }
    }
  }
  depends_on = [kubernetes_service.hugo]
}