#!/usr/bin/env bash

# Sample usage
# ./executeTerraform.sh aws-user-a 123456789012 DevOpsSession1 210987654321 TerraformSession1

# Account Details
MANAGEMENT_USER_PROFILE=$1
DEVOPS_ACCOUNT=$2
ORG_ACCESS_ROLE="OrganizationAccountAccessRole"
ORG_ROLE_SESSION=$3

TERRAFORM_ACCOUNT=$4
TERRAFORM_ROLE="TerraformAccessRole"
TERRAFORM_ROLE_SESSION=$5

# Assume role from Management account to DevOps account
aws_credentials=$(aws sts assume-role --role-arn arn:aws:iam::$DEVOPS_ACCOUNT:role/$ORG_ACCESS_ROLE --role-session-name $ORG_ROLE_SESSION --output json --profile $MANAGEMENT_USER_PROFILE)

export AWS_ACCESS_KEY_ID=$(echo $aws_credentials|jq '.Credentials.AccessKeyId'|tr -d '"')
export AWS_SECRET_ACCESS_KEY=$(echo $aws_credentials|jq '.Credentials.SecretAccessKey'|tr -d '"')
export AWS_SESSION_TOKEN=$(echo $aws_credentials|jq '.Credentials.SessionToken'|tr -d '"')

aws sts get-caller-identity

# Assume role from DevOps account to Terraform account
aws_terra_credentials=$(aws sts assume-role --role-arn arn:aws:iam::$TERRAFORM_ACCOUNT:role/$TERRAFORM_ROLE --role-session-name $TERRAFORM_ROLE_SESSION --output json)

export AWS_ACCESS_KEY_ID=$(echo $aws_terra_credentials|jq '.Credentials.AccessKeyId'|tr -d '"')
export AWS_SECRET_ACCESS_KEY=$(echo $aws_terra_credentials|jq '.Credentials.SecretAccessKey'|tr -d '"')
export AWS_SESSION_TOKEN=$(echo $aws_terra_credentials|jq '.Credentials.SessionToken'|tr -d '"')

aws sts get-caller-identity

# Run Terraform init and plan to generate a plan
# the same needs to be then applied using the above credentials
terraform init
terraform plan -out account-$TERRAFORM_ACCOUNT.tfplan
# terraform apply