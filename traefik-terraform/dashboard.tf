resource "kubernetes_service" "dashboard" {
  metadata {
    name = "${var.name}-dashboard"
    namespace = var.namespace
  }

  spec {
    selector = {
      "app.kubernetes.io/component" = "traefik"
    }

    port {
      name        = "dashboard"
      protocol    = "TCP"
      port        = 8080
    }
  }
}


resource "kubernetes_ingress" "dashboard" {
  metadata {
    name = "${var.name}-dashboard"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class" = "traefik"
      "traefik.ingress.kubernetes.io/router.tls" = "true"
      "traefik.ingress.kubernetes.io/router.tls.certresolver" = "default"
    }
  }

  spec {
    rule {
      host = "minikube.aves.internal"
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.dashboard.metadata.0.name
            service_port = 8080
          }
        }
      }
    }
  }
}
