resource "kubernetes_service" "whoami" {
  metadata {
    name = "${var.name}-whoami"
    namespace = var.namespace
  }

  spec {
    selector = {
      "app" = "whoami"
    }

    port {
      name        = "web"
      protocol    = "TCP"
      port        = 80
    }
  }
}


resource "kubernetes_ingress" "whoami" {
  metadata {
    name = "${var.name}-whoami"
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
          path = "/whoami"
          backend {
            service_name = kubernetes_service.whoami.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}


resource "kubernetes_deployment" "whoami" {
  metadata {
    name = "${var.name}-whoami"
    namespace = var.namespace
    labels = {
      "app" = "whoami"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        "app" = "whoami"
      }
    }

    template {
      metadata {
        labels = {
          "app" = "whoami"
        }
      }

      spec {
        container {
          image = "traefik/whoami"
          name  = "whoami"

          port {
            name = "web"
            container_port = 80
          }
        }
      }
    }
  }
}
