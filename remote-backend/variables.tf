variable "s3-bucket-name" {
  default = "terraform-state-file-bucket"
  type = string
}

variable "dynamodb-table-name" {
  default = "terraform-lock-table"
  type = string
}

