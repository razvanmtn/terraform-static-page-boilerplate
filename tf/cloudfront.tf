data "aws_cloudfront_cache_policy" "cache_policy" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  default_root_object = var.s3_index_document
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = false
  comment             = var.cloudfront_description

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["HEAD", "GET", "OPTIONS"]
    compress        = true

    target_origin_id       = "S3-${aws_s3_bucket.bucket.id}"
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
  }

  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.bucket.id}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  depends_on = [aws_s3_bucket.bucket]
}
