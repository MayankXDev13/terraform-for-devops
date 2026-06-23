resource "aws_s3_bucket" "remote-s3" {
  bucket = var.s3-bucket-name

  tags = {
    Name        = "terraform-state-bucket"
    Environment = "Dev"
  }
}
