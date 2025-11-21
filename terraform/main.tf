terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # use a stable release
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"  # optional, if using named AWS CLI profiles
}

# IAM User

# aws_iam_user.first_user
resource "aws_iam_user" "first_user" {
  name = "Anuk"
  path = "/Terraform/"
  force_destroy = true

  tags = {
     "Owner"   = "Yawo"
     "Purpose" = "Terraform Course"
  }
}

# aws_iam_user.second_user
resource "aws_iam_user" "second_user" {
  name = "Akekle"
  path = "/Terraform/"
  force_destroy = true

  tags = {
     "Owner"   = "Yawo"
     "Purpose" = "Terraform Course"
  }
}

# IAM Group

resource "aws_iam_group" "admin" {
name = "Admin"

depends_on = [
  aws_iam_user.first_user
]
}

resource "aws_iam_group_membership" "admin_group" {
    name = "admin-group-members"
    users =  [aws_iam_user.first_user.name, aws_iam_user.second_user.name ]   #["Class5", "Class5a"]
    group =  aws_iam_group.admin.name         #"Admin"

}

# data.aws_vpc.feb
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
} 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc_12"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}