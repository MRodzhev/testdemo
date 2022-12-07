provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  vpc_id = var.vpc_id
  
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
  
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20220912"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}


resource "aws_instance" "JenkinsTest" {

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.jenkins-sg.name]
  user_data              = "${file("install_jenkins.sh")}, ${file("install_docker.sh")}"
  tags = {
    Name = "JenkinsMaster"
  }
}

resource "aws_instance" "DockerTest" {

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.jenkins-sg.name]
  user_data              = "${file("install_docker.sh")}"
   tags = {
    Name = "DockerDeploy"
  }
}

  