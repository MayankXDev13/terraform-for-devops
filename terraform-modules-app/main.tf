# dev infrastructure
module "dev-infra" {
  source         = "./infra-app"
  env            = var.env
  bucket_name    = var.bucket_name
  instance_count = var.instance_count
  ec2_instance_type = var.ec2_instance_type
  ec2_ami_id     = var.ec2_ami_id
  hash_key       = var.hash_key
}