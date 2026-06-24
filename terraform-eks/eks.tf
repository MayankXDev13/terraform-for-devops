module "eks" {

  # import the module template
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.5"

  # cluster info (control plane)
  name                                     = local.name
  kubernetes_version                       = "1.33"
  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true
  vpc_id                                   = module.vpc.vpc_id
  subnet_ids                               = module.vpc.private_subnets

  addons = {
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
  }

  # control plane network 
  control_plane_subnet_ids = module.vpc.intra_subnets

  # managing nodes in the cluster
  eks_managed_node_groups = {
    mayankxdev-cluster-ng = {
      instance_types                        = ["t3.medium"]
      attach_cluster_primary_security_group = true
      min_size                              = 2
      max_size                              = 3
      desired_size                          = 2
      capacity_type                         = "SPOT"
      disk_size                             = 20
    }
  }


  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}



