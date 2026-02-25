# terraform.tfvars.example
# Copy this file to terraform.tfvars and fill in your values

# AWS Configuration
aws_region = "us-east-1"

# Cluster Configuration
cluster_name    = "mobilefirst-dev"
cluster_version = "1.34"

# Existing VPC and NAT Gateway
vpc_id                  = "vpc-0bc5a65352408085d"
existing_nat_gateway_id = "#############"

# Availability Zones (should match your VPC's AZs)
availability_zones = ["us-east-1a", "us-east-1c"]

# Private Subnet CIDRs for EKS (ensure these don't overlap with existing subnets)
private_subnet_cidrs = ["10.0.7.0/24", "10.0.8.0/24", ]


#ami configurtation for eks nodes
snapshot_disk_size = 20


# Microservices Node Group Configuration
microservices_node_group_name = "eks-microservices"
microservices_instance_types  = ["t3a.medium"]
microservices_disk_size       = 30
microservices_desired_size    = 2 //initially set to 2 for availability
microservices_min_size        = 1 //increase min size to 2 for high availability and cluster upgrades
microservices_max_size        = 10

# Enable features
enable_cluster_autoscaler = true
enable_irsa               = true
# ecr variables
ecr_names = ["mobilefirst/kyc", 
"mobilefirst/portfolio",
]

image_mutability = "IMMUTABLE"
# Tags

owners       = "hareesh"
environment  = "development"
project_name = "mobilefirst-eks"
