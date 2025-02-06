# Terraform AWS EKS Cluster Setup

This project uses Terraform to provision an Amazon EKS cluster along with the necessary VPC, subnets, and ECR repository.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
- AWS credentials configured in your environment
- An SSH key pair for SSH access to the EC2 instances

## Providers

- **AWS** (>= 4.67.0)
- **kubectl** (>= 1.14.0)

## Modules

- **VPC**: Provisions a VPC with public and private subnets.
- **EKS**: Creates an EKS cluster with managed worker nodes.
- **ECR**: Sets up an ECR repository for storing Docker images.

## Usage

1. **Clone the repository**:

   ```sh
   git clone https://github.com/iam-kishoret/iac-eks-terraform.git
   cd iac-eks-terraform
Initialize Terraform:

sh
terraform init
Review and customize variables:

Edit the variables.tf file to set your desired values for the variables.

Apply the Terraform configuration:

sh
terraform apply
This will create the necessary resources in your AWS account.

Access the EKS cluster:

Configure your kubectl to use the EKS cluster:

sh
aws eks --region <your-region> update-kubeconfig --name <your-cluster-nam