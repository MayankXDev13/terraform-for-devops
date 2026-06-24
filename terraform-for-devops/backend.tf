terraform {
  backend "s3" {
    bucket       = "terraform-state-file-bucket-23-06-2026-9-44"
    key          = "terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
    # dynamodb_table = "terraform-lock-table"  # this deprecated use use_lockfile = true
  }
}