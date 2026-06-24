# key pair
resource "aws_key_pair" "deployer" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("infra-app/terra-key-ec2.pub")

  tags = {
    Name        = "${var.env}-infra-app-key"
    Environment = var.env
  }
}

# VPC & Security Group
resource "aws_default_vpc" "default" {

  tags = {
    Name        = "${var.env}-infra-app-vpc"
    Environment = var.env
  }

}


resource "aws_security_group" "my-sg" {
  name        = "${var.env}-infra-app-sg"
  description = "security group to manage traffic to ec2 instances by terraform"
  vpc_id      = aws_default_vpc.default.id # interpolation 

  # inbound rules > is called ingress
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh traffic"

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow http traffic"
  }

  # outbound rules > is called egress

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # all protocols
    cidr_blocks = ["0.0.0.0/0"] # all ips
    description = "allow all traffic"
  }

  tags = {
    Name        = "${var.env}-infra-app-sg"
    Environment = var.env
  }



}

# ec2 instance
resource "aws_instance" "my-instance" {  
  count = var.instance_count # meta argument
  depends_on             = [aws_security_group.my-sg, aws_key_pair.deployer]
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  user_data              = file("install_nginx.sh") # user_data is file run when instance is starting for the first time

  root_block_device {
    volume_type = "gp3"
    volume_size = var.env == "prod" ? 20 : 10 # terraform use ternary operator here
  }

  tags = {
    Name        = "${var.env}-infra-app-ec2"
    Environment = var.env
  }
}





