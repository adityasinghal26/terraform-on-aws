terraform {
  backend "s3" {
    profile        = "default"
    bucket         = "terraform-account-a-dev-state"
    key            = "terraform.dev.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-dev-state-lock"
  }
}
