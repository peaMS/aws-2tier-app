resource "kubernetes_secret" "backend_env" {
  metadata {
    name = "ecommerce-db-secret"
  }

  data = {
    DB_HOST     = base64encode("ecommerce-db.c9g4wecya4uf.eu-north-1.rds.amazonaws.com")
    DB_PORT     = base64encode("5432")
    DB_NAME     = base64encode("ecommerce")
    DB_USER     = base64encode("postgres")
    DB_PASSWORD = base64encode("MySecurePass123!") # replace as needed
  }

  type = "Opaque"
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "ecommerce-backend"
    labels = {
      app = "ecommerce-backend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "ecommerce-backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "ecommerce-backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = "aws_account_id.dkr.ecr.eu-north-1.amazonaws.com/backend-rds:latest"
          port {
            container_port = 3000
          }

          env {
            name = "DB_HOST"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_env.metadata[0].name
                key  = "DB_HOST"
              }
            }
          }

          env {
            name = "DB_PORT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_env.metadata[0].name
                key  = "DB_PORT"
              }
            }
          }

          env {
            name = "DB_NAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_env.metadata[0].name
                key  = "DB_NAME"
              }
            }
          }

          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_env.metadata[0].name
                key  = "DB_USER"
              }
            }
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.backend_env.metadata[0].name
                key  = "DB_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend_lb" {
  metadata {
    name = "ecommerce-backend-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.backend.metadata[0].labels["app"]
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
