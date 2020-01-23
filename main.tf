# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-bucket-veeratest2323232323"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformDemo"
}
}
