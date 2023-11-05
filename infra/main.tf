// Kubernetes
resource "aws_eks_cluster" "dev-eks" {
  name     = "dev-eks"
  role_arn = aws_iam_role.dev-eks-role.arn

  vpc_config {
    subnet_ids = [aws_subnet.dev-subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.dev-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.dev-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.dev-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.dev-eks.certificate_authority[0].data
}

resource "aws_eks_node_group" "dev-eks-nodegroup" {
  cluster_name    = aws_eks_cluster.dev-eks.name
  node_group_name = "dev-eks-nodegroup"
  node_role_arn   = aws_iam_role.dev-eks-role.arn
  subnet_ids      = [aws_subnet.dev-subnet.id]
  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }
  depends_on = [aws_eks_cluster.dev-eks]
}

// Iam
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "dev-eks-role" {
  name               = "dev-eks-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "dev-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.dev-eks-role.name
}

resource "aws_iam_role_policy_attachment" "dev-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.dev-eks-role.name
}

// Network
resource "aws_subnet" "dev-subnet" {
  vpc_id = aws_vpc.dev-main-vpc.id
}

resource "aws_vpc" "dev-main-vpc" {

}

// ECR
resource "aws_ecr_repository" "gameblast-ecr" {
  name                 = "gameblast-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_url" {
  value = aws_ecr_repository.gameblast-ecr.repository_url
}
