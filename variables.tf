# Variables for EKS Cluster Configuration

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.33"
}

# VPC Configuration
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "existing_nat_gateway_id" {
  description = "ID of the existing NAT Gateway to use"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for subnet creation"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "snapshot_disk_size" {
  description = "Disk size in GB for worker nodes"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_cluster_autoscaler" {
  description = "Enable cluster autoscaler tags on node groups"
  type        = bool
  default     = true
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = true
}


# Business Division
variable "owners" {
  description = "organization this Infrastructure belongs"
  type        = string
  default     = ""
}

# environment name
variable "environment" {
  description = "project this Infrastructure belongs"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "mobilefirst-eks"
}

variable "ecr_names" {
  description = "The list of ecr names to create"
  type        = list(string)
  default     = null
}
variable "image_mutability" {
  description = "Provide image mutability"
  type        = string
  default     = "MUTABLE"
}

variable "microservices_node_group_name" {
  description = "Name of the microservices node group"
  type        = string
}

variable "microservices_instance_types" {
  description = "EC2 instance types for microservices node group"
  type        = list(string)
}

variable "microservices_disk_size" {
  description = "Root volume size (GiB)"
  type        = number
}

variable "microservices_desired_size" {
  type = number
}
variable "microservices_min_size" {
  type = number
}
variable "microservices_max_size" {
  type = number
}
