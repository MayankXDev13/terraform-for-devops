resource "aws_s3_bucket" "my_bucket" {
  bucket = "mayankxdev-terrform-bucket-dev-23-06"

  tags = {
    Name = "${var.env}-bucket"
    Environment = var.env
  }
}
