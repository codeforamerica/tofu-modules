provider "aws" {
  default_tags {
    tags = {
      service = var.service
    }
  }
}
