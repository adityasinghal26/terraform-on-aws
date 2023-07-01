terraform {
  backend "s3" {
    bucket         = "terraform-dev-state-bucket"
    key            = "terraform.dev.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dev-state-lock"
  }
}
