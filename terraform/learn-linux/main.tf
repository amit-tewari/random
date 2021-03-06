# https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f
# https://letslearndevops.com/2018/08/23/terraform-get-latest-centos-ami/ 
# https://github.com/otassetti/terraform-aws-ami-search/blob/master/variables.tf

provider "aws" {
  region = "us-east-1"
}

#variable "ami_name" {}
#variable "ami_id" {}
#variable "ami_key_pair_name" {}

output "ami_name" {
 value = data.aws_ami.latest-debian.name
}

# Debian Account ID : 379101102735
data "aws_ami" "latest-debian" {
  most_recent = true
  owners = ["136693071363"] # Debian 10 SPI account

  filter {
      name   = "name"
      values = ["debian-10-amd64-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

data "aws_ami" "centos" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

data "aws_ami" "latest_ecs" {
most_recent = true
owners = ["591542846629"] # AWS

  filter {
      name   = "name"
      values = ["*amazon-ecs-optimized"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }  
}

resource "aws_key_pair" "learn" {
  key_name   = "learn"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0RlnTzqxUr8xxKEA2P46QnUIpwNTX+NxuBtqzfcXoo learn"
}

resource "aws_vpc" "learn" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "learn" {
  cidr_block = "${cidrsubnet(aws_vpc.learn.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.learn.id}"
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "ingress-all-learn" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.learn.id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "learn" {
  ami = "${data.aws_ami.latest-debian.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.learn.key_name}"
  security_groups = ["${aws_security_group.ingress-all-learn.id}"]
  subnet_id = "${aws_subnet.learn.id}"
  tags = {
    name = data.aws_ami.latest-debian.name
  }
}

resource "aws_eip" "learn" {
  instance = "${aws_instance.learn.id}"
  vpc      = true
}

resource "aws_internet_gateway" "learn" {
  vpc_id = "${aws_vpc.learn.id}"
}

resource "aws_route_table" "learn" {
  vpc_id = "${aws_vpc.learn.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.learn.id}"
  }
}
resource "aws_route_table_association" "learn" {
  subnet_id      = "${aws_subnet.learn.id}"
  route_table_id = "${aws_route_table.learn.id}"
}
