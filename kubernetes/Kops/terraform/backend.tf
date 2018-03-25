terraform {
  backend "s3" {
    bucket = "kops-terraform-s3"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
