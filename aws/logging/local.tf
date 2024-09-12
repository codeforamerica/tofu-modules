locals {
  prefix = "${var.project}-${var.environment}"

  datadog_lambda = [
    for lambda in data.aws_lambda_functions.all.function_names :
    # HCL uses Perl style regex flags, so we use (?i) to make the regex case
    # insensitive.
    lambda if length(regexall("^(?i)Datadog[a-zA-Z]*-ForwarderStack-", lambda)) > 0
  ]
}
