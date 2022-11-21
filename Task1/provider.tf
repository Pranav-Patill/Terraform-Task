provider "aws" {
    region = "us-east-1"
    profile = "default"
    # access_key = "AKIAZCLLKJQ6ULJSF4HO"
    # secret_key = "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"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}