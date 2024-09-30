output "id" {
  value = aptible_endpoint.endpoint.endpoint_id
}

output "fqdn" {
  value = aptible_endpoint.endpoint.virtual_domain
}

output "hostname" {
  value = aptible_endpoint.endpoint.external_hostname
}
