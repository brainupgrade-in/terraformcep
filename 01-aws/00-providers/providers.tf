terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.region
}

variable "region"{
  default = "ap-southeast-1"
}