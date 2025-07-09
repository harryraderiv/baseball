terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet"
  default     = ["10.10.0.0/24"]
}

resource "random_id" "server_id" {
  keepers = {
    ami_id = var.web_ami_type
    instance_type = var.web_instance_type
  }
  byte_length = 4
}

resource "aws_vpc" "webvpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "WebVPC"
  }
}

resource "aws_instance" "app_server" {
  ami           = var.web_ami_type
  instance_type = var.web_instance_type

  tags = {
    Name = "web ${random_id.server.hex}"
  }
}