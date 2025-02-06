terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway    = true
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = var.vpc_name
  }
}

# EKS Cluster Module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  create_iam_role = true

  eks_managed_node_groups = {
    worker_group = {
      name = var.worker_group_name

      instance_types = var.instance_types
      min_size     = var.worker_min_size
      desired_size = var.worker_desired_size
      max_size     = var.worker_max_size

      subnet_ids = module.vpc.private_subnets

      create_iam_role = true
      iam_role_additional_policies = {
        ecr_access = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
        eks_worker_policy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        eks_cni_policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        cloudwatch_logs = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
      }

      tags = {
        Name = var.worker_group_name
      }
    }
  }

  tags = {
    Environment = var.environment
    Name        = var.cluster_name
  }
}

# ECR Repository
resource "aws_ecr_repository" "metaphor" {
  name = var.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.ecr_repo_name
    Environment = var.environment
  }
}
# Granting cluster admin role to run kubectl 
resource "kubectl_manifest" "aws_auth" {
  depends_on = [module.eks] # Ensures EKS is created before applying ConfigMap

  yaml_body = templatefile("${path.module}/aws-eks-clus-admin-auth-configmap.yaml", {
    k8s_user     = var.k8s_user
    k8s_user_arn = "arn:aws:iam::${var.account_id}:user/${var.k8s_user}"
  })
}

