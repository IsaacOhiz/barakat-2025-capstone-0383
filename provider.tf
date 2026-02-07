terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"

   default_tags {
  tags = {
    "Project"       = "Bedrock"
    "Project_Alt" = "barakat-2025-capstone"
     }
  }
}
