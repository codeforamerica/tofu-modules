data "aws_caller_identity" "identity" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_elb_service_account" "current" {}

# Find the lambda function for the Datadog forwarder so that we can use it as a
# destination for CloudWatch log subscriptions.
data "aws_lambda_functions" "all" {}

data "aws_lambda_function" "datadog" {
  for_each = length(local.datadog_lambda) > 0 && var.log_groups_to_datadog ? toset(["this"]) : toset([])

  function_name = local.datadog_lambda[0]
}
