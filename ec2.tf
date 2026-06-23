# key pair

resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# VPC & Security Group

resource "aws_default_vpc" "default" {

}


resource "aws_security_group" "my-sg" {
  name        = "automate-sg"
  description = "security group to manage traffic to ec2 instances by terraform"
  vpc_id      = aws_default_vpc.default.id # interpolation expressions are used to reference other resource attributes, here we are referencing the id attribute of the default vpc

  #  inbound rules > is called ingress

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



}

# ec2 instance

resource "aws_instance" "my-instance" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  user_data              = file("install_nginx.sh") # user_data is file run when instance is starting for the first time

  root_block_device {
    volume_type = var.ec2_root_volume_type
    volume_size = var.ec2_root_storage_size
  }

  tags = {
    Name = "mayankxdev"
  }
}



