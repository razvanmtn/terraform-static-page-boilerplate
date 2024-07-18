#
# Common variables
#

variable "common_region" {
  type        = string
  description = "Region to work on."
  default     = "eu-central-1"
}

variable "common_profile" {
  type        = string
  description = "AWS Profile configuration"
  default     = "default"
}

#
# S3 Bucket
#

variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket Name"
  default     = "static-page-bucket"
}

variable "s3_index_document" {
  type        = string
  description = "S3 Bucket Index HTML Document"
  default     = "index.html"
}

variable "s3_error_document" {
  type        = string
  description = "S3 Bucket Error HTML Document"
  default     = "error.html"
}

variable "s3_bucket_policy_id" {
  type        = string
  description = "S3 Bucket Policy Id"
  default     = "PublicReadGetObjectPolicy"
}

variable "s3_bucket_policy_sid" {
  type        = string
  description = "S3 Bucket Policy Statement Id"
  default     = "PublicReadGetObject"
}

variable "s3_dist_folder_name" {
  type        = string
  description = "Folder name that contains S3 files"
  default     = "dist"
}

#
# Cloudfront
#

variable "cloudfront_description" {
  type        = string
  description = "Cloudfront distribution description"
  default     = "Static Page"
}
