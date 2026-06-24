module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "mayankxdev-vpc-${var.env}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

/*

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2-${var.env}"
  public_key = file("terra-key-ec2.pub")

  tags = {
    Name        = "${var.env}-keypair"
    Environment = var.env
  }
}

# Security Group
resource "aws_security_group" "my_sg" {
  name        = "automate-sg-${var.env}"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.env}-sg"
    Environment = var.env
  }
}

# EC2 Instances
resource "aws_instance" "my_instance" {
  for_each = {
    mayankxdev-micro  = "t2.micro"
    mayankxdev-medium = "t2.medium"
  }

  depends_on = [
    aws_security_group.my_sg,
    aws_key_pair.deployer
  ]

  ami                         = var.ec2_ami_id
  instance_type               = each.value
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true

  user_data = file("install_nginx.sh")

  root_block_device {
    volume_type = var.ec2_root_volume_type
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size
  }

  tags = {
    Name        = each.key
    Environment = var.env
  }
}

*/