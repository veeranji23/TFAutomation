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
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "TFA-Integration with UI"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_s3_bucket" "b" {
  bucket = "n-1234-test-bucket-terraform"
  acl    = "private"

  tags = {
    Name        = "N-12345-Terraformdemo-bucket"
    Environment = "Dev-Env"
  }
  versioning {
    enabled = true
  }
}
resource "aws_vpc" "vpc" {
  cidr_block       = "190.160.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TerraformVPC"
    Location = "Hyderabad"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "190.160.0.0/16"

  tags = {
    Name = "Subnet1"
  }
}
