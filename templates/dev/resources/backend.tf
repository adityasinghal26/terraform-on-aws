terraform {
  backend "s3" {
    profile        = "default"
    bucket         = "terraform-account-a-dev-state"
    key            = "terraform.dev.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dev-state-lock"
  }
}
