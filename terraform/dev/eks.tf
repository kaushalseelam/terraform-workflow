module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.23.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.30"
  subnet_ids         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity     = 1
      max_capacity         = 2
      min_capacity         = 1

      instance_type = "t3.small"

      additional_userdata = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]

    }
  }
}



data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
