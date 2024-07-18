locals {
  dist_path = abspath("${path.module}/../${var.s3_dist_folder_name}")
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "static_page" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.s3_index_document
  }

  error_document {
    key = var.s3_error_document
  }
}

resource "aws_s3_bucket_policy" "static_page_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = var.s3_bucket_policy_id
    Statement = [
      {
        Sid       = var.s3_bucket_policy_sid
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
      },
    ]
  })

  depends_on = [null_resource.pause]
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "upload_object" {
  bucket       = aws_s3_bucket.bucket.id
  for_each     = fileset(local.dist_path, "*")
  key          = each.value
  source       = "${local.dist_path}/${each.value}"
  etag         = filemd5("${local.dist_path}/${each.value}")
  content_type = "text/html"
}
