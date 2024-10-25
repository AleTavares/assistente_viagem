terraform {
  required_version = ">= 1.6.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }

  backend "s3" {
    bucket = "Bucket com o State"
    key    = "prj-assistente-viagem/terraform.tfstate"
    region = "us-east-1"
  }
}
