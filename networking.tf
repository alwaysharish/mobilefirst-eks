# networking.tf - Subnet and Route Table Configuration for EKS

# Data source to get existing VPC information
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Data source for existing NAT Gateway
data "aws_nat_gateway" "existing" {
  id = var.existing_nat_gateway_id
}

# Create private subnets for EKS
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    local.tags,
    {
      Name                                        = "${var.cluster_name}-private-${var.availability_zones[count.index]}"
      "kubernetes.io/role/internal-elb"           = "1"
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = merge(
    local.tags,
    {
      Name = "${var.cluster_name}-eks-private-rt"
    }
  )
}

# Create route to NAT Gateway for internet access
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.existing_nat_gateway_id
}

# Associate private subnets with route table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Output subnet IDs for use in EKS configuration
output "private_subnet_ids" {
  description = "IDs of the private subnets created for EKS"
  value       = aws_subnet.private[*].id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}
