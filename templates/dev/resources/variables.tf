##########################
# VPC variables
##########################

variable "infra_region" {
    type = string
}

variable "infra_name" {
    type = string
}

variable "vpc_apps_cidr" {
    type = string
}

##########################
# Subnet variables
##########################

variable "database_private_subnets" {
    type = list(string)
}

variable "eks_private_subnets" {
    type = list(string)
}

variable "ingress_private_subnets" {
    type = list(string)
}

variable "ingress_public_subnets" {
    type = list(string)
}

##########################
# Gateway variables
##########################

variable "enable_nat_gateway" {
    type = string
}

variable "single_nat_gateway" {
    type = string
}

##########################
# Environment variables
##########################

variable "project" {
    type = string
}

variable "environment" {
    type = string
}

##########################
# EKS variables
##########################

variable "cluster_version" {
    type = string
}

variable "nodegroup_1" {
    type = object({
        ami_type       = string
        instance_types = list(string)
        min_size       = number
        max_size       = number
        desired_size   = number
        taints         = map(any)
        tags           = map(any)
    })
}

variable "nodegroup_2" {
    type = object({
        ami_type       = string
        instance_types = list(string)
        min_size       = number
        max_size       = number
        desired_size   = number
        taints         = map(any)
        tags           = map(any)
    })
}

variable "nodegroup_3" {
    type = object({
        ami_type       = string
        instance_types = list(string)
        min_size       = number
        max_size       = number
        desired_size   = number
        taints         = map(any)
        tags           = map(any)
    })
}

##########################
# EKS Add-ons variables
##########################

variable "addons_repo" {
  description = "addons_repo"
  type        = string
  default     = "https://github.com/aws-samples/eks-blueprints-add-ons.git"
}

variable "addons_path" {
  description = "addons_path"
  type        = string
  default     = "chart"
}

variable "enable_amazon_eks_aws_ebs_csi_driver" {
  type = string
}

variable "enable_aws_for_fluentbit" {
  type = string
}

variable "aws_for_fluentbit_create_cw_log_group" {
  type =string
}

variable "enable_aws_load_balancer_controller" {
  type = string 
}

variable "enable_cluster_autoscaler" {
  type = string
}

variable "enable_karpenter" {
  type = string 
}

variable "enable_keda" {
  type = string
}

variable "enable_metrics_server" {
  type =string
}

variable "enable_prometheus" {
  type = string
}

variable "enable_amazon_prometheus" {
  type =string
}

variable "enable_traefik" {
  type = string
}

variable "enable_vpa" {
  type =string
}

variable "enable_yunikorn" {
  type = string
}

variable "enable_argo_rollouts" {
  type = string
}

variable "enable_external_secrets" {
  type = string
}

variable "enable_amazon_eks_adot" {
  type = string
}

variable "enable_adot_collector_java" {
  type = string
}

variable "enable_cert_manager" {
  type = string
}

variable "argocd_cred_sm_name" {
  type = string
}