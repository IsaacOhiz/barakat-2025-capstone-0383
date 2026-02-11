module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.5.0"

  name = "project-bedrock-vpc"
  cidr = var.vpc_cidr

    azs             = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true

    public_subnet_tags = {
        "kubernetes.io/role/elb" = "1"
        "Project" = "Bedrock"
    }
    private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = "1"
        "Project" = "Bedrock"
    }
    tags = {
        "Project" = "barakat-2025-capstone"
    }
}