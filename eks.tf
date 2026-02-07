module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.30"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

 cluster_addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {}
}
  eks_managed_node_groups = {
    general = {
      min_size     = 2
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.micro"]
    }
  }

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    dev_view = {
      principal_arn     = aws_iam_user.dev_user.arn
      kubernetes_groups = ["bedrock-dev-group"]
      policy_associations = {
        view_policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }
}
