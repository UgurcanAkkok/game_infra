kubernetes = {
  name                 = "goodblast-eks"
  instance_type        = "t2.micro"
  node_group_name      = "goodblast-eks-nodegroup"
  scaling_min_size     = 1
  scaling_max_size     = 3
  scaling_desired_size = 2
}

iam = {
  kubernetes_role_name       = "goodblast-eks-role"
}

network = {
    vpc_cidr_block  = "10.0.0.0/16"
    eks_cidr_block1 = "10.0.0.0/20"
    eks_cidr_block2 = "10.0.16.0/20"
}

