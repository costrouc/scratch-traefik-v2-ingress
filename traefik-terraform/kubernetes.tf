provider "kubernetes" {
  config_path    = "~/.kube/config"
}


resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace
  }
}
