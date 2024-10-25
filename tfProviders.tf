provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner      = "tavares"
      managed-by = "terraform"
      enviroment = "dev"
    }
  }
}
