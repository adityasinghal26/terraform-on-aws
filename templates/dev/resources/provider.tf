provider "aws" {
  region = local.region
  assume_role {
    role_arn = "arn:aws:sts::756272654665:assumed-role/TerraformAccessRole/TerraformSession1"
  }
}