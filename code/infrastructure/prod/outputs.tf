output "domain_name" {
  description = "The cloudfront domain name."
  value = module.cloudFront.domain_name
}