terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
  required_version = ">= 1.7"
}

provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = "my-web-bucket-adlf34"
}

module "cloudFront" {
  source             = "../modules/cloudFront"
  bucket_domain_name = module.s3.bucket_domain_name
}

module "cloudwatch_dashboard" {
  source = "../modules/cloudwatch"
}