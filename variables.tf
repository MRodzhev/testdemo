variable "aws_region" {
  default = "eu-central-1"
}

variable "instance_type" {
  default = "t2.micro"
}


 variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(any)
  default     = ["80", "443", "22", "8080", "5000"]
}

variable "vpc_id" {
  description = "VPC for Jenkins"
  default = "vpc-02ea72ca3f2ef7ecd"
}

variable "cidr_block" {
  description = "CIDR Block to allow Jenkins Access"
  default = "0.0.0.0/0"
}

variable "key_name" {
  description = "Name of keypair to ssh"
  default = "sshforservers"
}



