terraform {
  cloud {
    organization = "zux"
    workspaces {
      name = "temp"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}


resource "aws_subnet" "example_subnet" {
  vpc_id     = "vpc-06b850f7a9526872e"
  cidr_block = "172.31.0.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e0820ad173f20fbb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet.id

  tags = {
    Name = var.instance_name
  }
}

