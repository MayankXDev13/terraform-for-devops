data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "spot_sg" {
  name        = "spot-instance-sg"
  description = "Security group for spot instance"
  vpc_id      = data.aws_vpc.default.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "spot-instance-sg"
  }
}



resource "aws_instance" "spot" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.spot_sg.id]

  # Spot instance request
  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "one-time" # or "persistent"
      instance_interruption_behavior = "terminate"
    }
  }

  associate_public_ip_address = true

  # Optional: add your key pair name
  key_name = "mayank"

  root_block_device {
    volume_size           = 20 # GB
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "spot-t3-medium"
  }
}
