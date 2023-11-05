kubernetes = {
  name                 = "gameblast-dev-eks"
  instance_type        = "t2.micro"
  node_group_name      = "gameblast-dev-eks-nodegroup"
  scaling_min_size     = 1
  scaling_max_size     = 1
  scaling_desired_size = 1
}

iam = {
  kubernetes_role_name       = "dev-gameblast-eks-role"
}

network = {
    vpc_cidr_block  = "10.1.0.0/16"
    eks_cidr_block1 = "10.1.0.0/20"
    eks_cidr_block2 = "10.1.16.0/20"
}
