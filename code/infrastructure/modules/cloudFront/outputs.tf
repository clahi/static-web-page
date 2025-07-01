output "domain_name" {
  description = "The domain name of teh cloudfront"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}