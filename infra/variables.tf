variable "kubernetes" {
  description = "Settings for EKS"
  type = object({
    name                 = string
    instance_type        = string
    node_group_name      = string
    scaling_min_size     = number
    scaling_max_size     = number
    scaling_desired_size = number
  })
  default = {
    name                 = "goodblast-dev-eks"
    instance_type        = "t2.micro"
    node_group_name      = "goodblast-dev-eks-nodegroup"
    scaling_min_size     = 1
    scaling_max_size     = 1
    scaling_desired_size = 1
  }
}

variable "iam" {
  description = "Settings for IAM"
  type = object({
    kubernetes_role_name       = string
  })
  default = {
    kubernetes_role_name       = "dev-goodblast-eks-role"
  }
}

variable "network" {
  description = "Settings for Network"
  type = object({
    vpc_cidr_block  = string
    eks_cidr_block1 = string
    eks_cidr_block2 = string
  })
  default = {
    vpc_cidr_block  = "10.1.0.0/16"
    eks_cidr_block1 = "10.1.0.0/20"
    eks_cidr_block2 = "10.1.16.0/20"
  }
}
