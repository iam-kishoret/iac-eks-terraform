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
   ```

2. **Initialize Terraform**:

   ```sh
   terraform init
   ```

3. **Review and customize variables**:

   Edit the `variables.tf` file to set your desired values for the variables.

4. **Apply the Terraform configuration**:

   ```sh
   terraform apply
   ```

   This will create the necessary resources in your AWS account.

5. **Access the EKS cluster**:

   Configure your `kubectl` to use the EKS cluster:

   ```sh
   aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
   ```

## Variables

- `region`: AWS region where the resources will be created.
- `vpc_name`: Name of the VPC.
- `vpc_cidr`: CIDR block for the VPC.
- `azs`: List of Availability Zones.
- `private_subnets`: List of private subnet CIDR blocks.
- `public_subnets`: List of public subnet CIDR blocks.
- `cluster_name`: Name of the EKS cluster.
- `cluster_version`: Version of the EKS cluster.
- `worker_group_name`: Name of the worker node group.
- `instance_types`: List of instance types for worker nodes.
- `worker_min_size`: Minimum number of worker nodes.
- `worker_desired_size`: Desired number of worker nodes.
- `worker_max_size`: Maximum number of worker nodes.
- `ecr_repo_name`: Name of the ECR repository.
- `environment`: Environment tag (e.g., `development`, `production`).
- `k8s_user`: Kubernetes user for cluster admin role.
- `account_id`: AWS account ID.

## Outputs

- `vpc_id`: ID of the created VPC.
- `eks_cluster_id`: ID of the created EKS cluster.
- `ecr_repo_url`: URL of the created ECR repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```
