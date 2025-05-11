terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29"

  vpc_id     = "vpc-046d82fecb3a43f6f"
  subnet_ids = ["subnet-04606b66f0f27d05f","subnet-07958a753d0a4b8aa","subnet-05adbb9712f564f77"]

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }

  tags = {
    Name = "my-eks-cluster"
  }
}
env {
  name  = "DB_HOST"
  value = "ecommerce-db.c9g4wecya4uf.eu-north-1.rds.amazonaws.com:5432"
}

env {
  name  = "DB_USER"
  value = "postgres"
}

env {
  name  = "DB_PASSWORD"
  value = "MySecurePass123!"
}

env {
  name  = "DB_NAME"
  value = "ecommerce"
}
env {
  name = "DB_HOST"
  valueFrom {
    secretKeyRef {
      name = "ecommerce-db-secret"
      key  = "DB_HOST"
    }
  }
}
env {
  name = "DB_PORT"
  valueFrom {
    secretKeyRef {
      name = "ecommerce-db-secret"
      key  = "DB_PORT"
    }
  }
}
env {
  name = "DB_USER"
  valueFrom {
    secretKeyRef {
      name = "ecommerce-db-secret"
      key  = "DB_USER"
    }
  }
}
env {
  name = "DB_PASSWORD"
  valueFrom {
    secretKeyRef {
      name = "ecommerce-db-secret"
      key  = "DB_PASSWORD"
    }
  }
}
env {
  name = "DB_NAME"
  valueFrom {
    secretKeyRef {
      name = "ecommerce-db-secret"
      key  = "DB_NAME"
    }
  }
}