resource "aws_default_vpc" "default" {

}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_security_group" "my_sg" {
  name   = "spot-instance-sg-${var.env}"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "spot" {
  ami                         = var.ec2_ami_id
  instance_type               = "t3.medium"
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true
  key_name                    = "mayank"

  root_block_device {
    volume_type = var.ec2_root_volume_type
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size
  }

  instance_market_options {
    market_type = "spot"

    spot_options {
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
    }
  }

  tags = {
    Name = "spot-t3-medium"
  }
}
