provider "aws" {
  region = "eu-north-1"
}

data "aws_eks_cluster" "cluster" {
  name = "my-eks-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

provider "kubernetes" {
  config_path = "C:\\Users\\Pea\\.kube\\config"
}
