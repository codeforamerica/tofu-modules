locals {
  prefix = "${var.project}-${var.environment}${var.service != "" ? "-${var.service}" : ""}"
}
