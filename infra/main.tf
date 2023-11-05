// Kubernetes
resource "aws_eks_cluster" "goodblast-eks" {
  name     = var.kubernetes.name
  role_arn = aws_iam_role.goodblast-eks-role.arn

  vpc_config {
    subnet_ids = [aws_subnet.goodblast-subnet-eks1.id,aws_subnet.gameblast-subnet-eks2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.goodblast-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.goodblast-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "goodblast-eks-nodegroup" {
  cluster_name    = aws_eks_cluster.goodblast-eks.name
  node_group_name = var.kubernetes.node_group_name
  node_role_arn   = aws_iam_role.goodblast-eks-role.arn
  subnet_ids      = [aws_subnet.goodblast-subnet-eks1.id,aws_subnet.gameblast-subnet-eks2.id]
  instance_types  = [var.kubernetes.instance_type]
  scaling_config {
    desired_size = var.kubernetes.scaling_desired_size
    min_size     = var.kubernetes.scaling_min_size
    max_size     = var.kubernetes.scaling_max_size
  }
  depends_on = [aws_eks_cluster.goodblast-eks]
}

output "endpoint" {
  value = aws_eks_cluster.goodblast-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.goodblast-eks.certificate_authority[0].data
}

// Iam
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "eks.amazonaws.com",
        "ec2.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "goodblast-eks-role" {
  name               = var.iam.kubernetes_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "goodblast-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.goodblast-eks-role.name
}

resource "aws_iam_role_policy_attachment" "goodblast-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.goodblast-eks-role.name
}

resource "aws_iam_role_policy_attachment" "goodblast-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.goodblast-eks-role.name
}

resource "aws_iam_role_policy_attachment" "goodblast-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.goodblast-eks-role.name
}

// Network
resource "aws_subnet" "goodblast-subnet-eks1" {
  vpc_id     = aws_vpc.goodblast-vpc.id
  cidr_block = var.network.eks_cidr_block1
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "goodblast-subnet-eks2" {
  vpc_id     = aws_vpc.goodblast-vpc.id
  cidr_block = var.network.eks_cidr_block2
  availability_zone = "eu-central-1b"
}

resource "aws_vpc" "goodblast-vpc" {
  cidr_block       = var.network.vpc_cidr_block
  instance_tenancy = "default"
}

// ECR
resource "aws_ecr_repository" "goodblast-ecr" {
  name                 = "goodblast-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_url" {
  value = aws_ecr_repository.goodblast-ecr.repository_url
}
