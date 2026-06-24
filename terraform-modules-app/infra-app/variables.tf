variable "env" {
  description = "This is the environment"
  type        = string
}


variable "bucket_name" {
  description = "this is the bucket name"
  type        = string
}

variable "instance_count" {
  description = "number of instances to create"
  type        = number
}


variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}


variable "ec2_ami_id" {
  description = "ami id of ec2 instance"
  type        = string
}

variable "hash_key" {
  description = "primary key of dynamodb table"
  type        = string
}