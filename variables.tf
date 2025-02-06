variable "region" {
  description = "AWS region"
  type        = string
}

variable "k8s_user" {
  description = "Kubernetes user"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "worker_group_name" {
  description = "Worker group name"
  type        = string
}

variable "instance_types" {
  description = "List of instance types for worker nodes"
  type        = list(string)
}

variable "worker_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "worker_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "worker_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}
variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

