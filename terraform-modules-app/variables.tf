variable "env" {
  default = "dev"
}

variable "bucket_name" {
  default = "mayankx-infra-app-bucket"
}

variable "instance_count" {
  default = 1
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ec2_ami_id" {
  default = "ami-0e5497a77ef21b5ac"
}

variable "hash_key" {
  default = "studenId"
}