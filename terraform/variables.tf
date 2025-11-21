
resource "aws_s3_bucket" "example_bucket" {
  bucket = "yawo_obi_12" # Bucket names must be globally unique

  tags = {
    Project     = "Example"
    Environment = "Dev"
  }
}

module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  version       = "6.1.4" # Use the latest version for new projects

  name          = "Training_1"
  instance_type = "t3.micro"
  ami           = "ami-0abcdef1234567890" # Replace with a valid AMI ID for your region
  subnet_id     = "10.0.1.0/24"      # Replace with your specific subnet ID
  monitoring    = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}