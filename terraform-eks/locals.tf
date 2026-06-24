locals {
  region = "us-east-2"
  name = "mayankxdev-eks-cluster"
  vpc_cidr = "10.0.0.0/16"
  availability_zones = ["us-east-2a","us-east-2b"]
  public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24","10.0.12.0/24"]   
  intra_subnets = ["10.0.5.0/24","10.0.6.0/24"]   
  env = "dev"
}

