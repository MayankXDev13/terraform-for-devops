variable "s3-bucket-name" {
  default = "terraform-state-file-bucket-23-06-2026-9-44"
  type = string
}

variable "dynamodb-table-name" {
  default = "terraform-lock-table"
  type = string
}

