 resource "aws_vpc" "ntairvpc" {
  cidr_block =     var.vpc_cidr
 }
 resource "aws_subnet" "sub1" {
cidr_block    =  "192.168.0.0/24" 
vpc_id       = aws_vpc.ntairvpc.id   
tags         = {
      Name = "subnet1"
    }
}

 resource "aws_security_group" "allow_tcp" {
  name        = "allow_tls"
  
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ntairvpc.id
  

  ingress {
    description      = "TLS from VPC"
    from_port        = var.port1
    to_port          = var.port1
    protocol         = "tcp"
    cidr_blocks      = [var.anywhere]
    
  }
ingress{
description = "allow all tcp"
from_port = 0
to_port = var.port2
protocol = "tcp"
cidr_blocks = [var.anywhere]

}
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anywhere]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Open all ports"
  }
}
resource "aws_instance" "server" {
  ami           = "ami-0ecc74eca1d66d8a6"
  instance_type = "t2.micro"
  key_name      = "my_id_rsa"
  subnet_id     = "subnet-0436715b8bf489487"


  tags = {
    Name = "VM"
  }
}