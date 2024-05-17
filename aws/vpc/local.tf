locals {
  azs    = data.aws_availability_zones.available.names
  prefix = "${var.project}-${var.environment}"
}
