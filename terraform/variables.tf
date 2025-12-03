resource "aws_s3_bucket" "yawo" {
  bucket = "yawo_obi_12"

  tags = {
    Name        = "yawo"
    Environment = "Dev"
  }
}

# Create a new host with instance type of c5.18xlarge with Auto Placement
# and Host Recovery enabled.
resource "aws_ec2_host" "test" {
  instance_type     = "t3.micro"
  availability_zone = "us-east-1"
  host_recovery     = "off"
  auto_placement    = "off"
}
