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
     "Purpose" = "terraform training"
  }
}

# aws_iam_user.second_user
resource "aws_iam_user" "second_user" {
  name = "Akekle"
  path = "/Terraform/"
  force_destroy = true

  tags = {
     "Owner"   = "Yawo"
     "Purpose" = "terraform training"
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
    users =  [aws_iam_user.first_user.name, aws_iam_user.second_user.name ]   
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
resource "aws_vpc" "second_1" {
  cidr_block       = "10.0.0.0/16" 
  instance_tenancy = "default"

  tags = {
    Name = "second_1"
  }
}
resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1"

  tags = {
    Name = "Default subnet for us-east-1"
  }
}