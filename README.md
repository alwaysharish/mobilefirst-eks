# AWS EKS Cluster Provisioning and Application Deployment using Terraform

## Project Overview

This project demonstrates end-to-end provisioning of an AWS EKS (Elastic Kubernetes Service) cluster using Terraform and deployment of containerized applications using Kubernetes.

The infrastructure is fully automated using Infrastructure as Code (IaC) principles, ensuring scalability, reliability, and repeatability.

---

## Architecture Components

The following AWS resources are provisioned using Terraform:

- VPC with public and private subnets
- Internet Gateway for public subnet internet access
- NAT Gateway for secure internet access from private subnet
- Route tables and subnet associations
- IAM roles and policies for EKS cluster and worker nodes
- OIDC provider for IAM Roles for Service Accounts (IRSA)
- EKS Cluster with managed node group
- Amazon ECR repository for storing Docker images
- EBS CSI Driver for dynamic volume provisioning
- GP3 Storage Class for persistent storage
- S3 backend for Terraform remote state management

---

## Terraform File Structure

| File Name | Description |
|---------|-------------|
| provider.tf | Defines AWS provider configuration |
| backend.tf | Configures S3 backend for storing Terraform state |
| networking.tf | Creates VPC, subnets, IGW, NAT Gateway, route tables |
| iam.tf | Defines IAM roles and policies |
| oidc.tf | Configures OIDC provider for service accounts |
| eks.tf | Creates EKS cluster |
| nodegroup.tf | Creates managed node group |
| ecr.tf | Creates ECR repository |
| ebs-csi-driver.tf | Configures EBS CSI driver |
| gp3-storageclass.tf | Defines Kubernetes storage class |
| variables.tf | Input variables |
| outputs.tf | Output values |
| terraform.tfvars | Variable values |

---

## Tools and Technologies Used

- AWS EKS (Elastic Kubernetes Service)
- Terraform
- Docker
- Kubernetes
- AWS CLI
- kubectl
- Amazon ECR
- Amazon S3

---

## Infrastructure Provisioning Steps

### Step 1: Initialize Terraform

terraform init

### Step 2: Validate Configuration

terraform validate

### Step 3: Review Execution Plan

terraform plan

### Step 4: Provision Infrastructure

terraform apply

---

## Kubernetes Cluster Access

After the cluster is created, configure kubectl:

aws eks update-kubeconfig --region <region> --name <cluster-name>

Verify nodes:
kubectl get nodes

---

## Application Deployment Steps

### Step 1: Build Docker Image
docker build -t my-app . 

### Step 2: Tag Image for ECR
docker tag my-app:latest <account-id>.dkr.ecr.<region>.amazonaws.com/my-app:latest

### Step 3: Push Image to ECR
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/my-app:latest

### Step 4: Deploy Application to EKS
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Verify deployment:
kubectl get pods
kubectl get svc

---

## Storage Configuration

This project uses:

- Amazon EBS CSI driver
- GP3 Storage Class
- Dynamic Persistent Volume provisioning

---

## Key Features

- Fully automated infrastructure provisioning using Terraform
- Secure networking using private subnets and NAT Gateway
- Highly available Kubernetes cluster
- Scalable node group configuration
- Remote Terraform state management using S3
- Container image storage using ECR
- Dynamic storage provisioning using EBS CSI driver

---

## Outcome

Successfully provisioned a production-ready AWS EKS cluster using Terraform and deployed containerized applications using Kubernetes.

This setup follows DevOps best practices including Infrastructure as Code, automation, scalability, and high availability.

---

## Author

Harish Maddila
DevOps Engineer  
