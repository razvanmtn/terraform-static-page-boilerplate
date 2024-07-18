output "s3_bucket_id" {
  value = aws_s3_bucket_website_configuration.static_page.website_endpoint
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
