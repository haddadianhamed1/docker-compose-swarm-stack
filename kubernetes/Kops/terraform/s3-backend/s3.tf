provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "b" {
  bucket = "kops-terraform-s3"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
output "s3-bucket" {
  value = ["${aws_s3_bucket.b.id}"]
}
