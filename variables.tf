variable "bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
}

variable "cloudfront_oai_comment" {
  description = "A comment to identify the CloudFront Origin Access Identity (OAI)"
  type        = string
  default     = "Test CloudFront OAI"
}

variable "s3_distribution_enabled" {
  description = "Flag to enable or disable the CloudFront distribution for the S3 bucket"
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "S3 bucket versioning configuration: Enabled or Disabled"
  type        = string
  default     = "Enabled"
}

variable "block_public_acls" {
  description = "Whether to block public access control lists (ACLs) for the S3 bucket"
  type        = bool
  default     = true
}

variable "cache_allowed_methods" {
  description = "List of HTTP methods that CloudFront caches responses for"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "Subset of allowed methods that are cached by CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "query_string" {
  description = "Specifies whether CloudFront forwards query strings to the origin"
  type        = bool
  default     = false
}

variable "cookies_forward" {
  description = "Specifies how CloudFront handles cookies: none, whitelist, all"
  type        = string
  default     = "none"
}

variable "viewer_protocol_policy" {
  description = "Policy that determines whether viewers can use HTTP and/or HTTPS to access content"
  type        = string
}

variable "restriction_type" {
  description = "Geo restriction type for CloudFront: none, whitelist, or blacklist"
  type        = string
}

variable "geo_locations" {
  description = "List of country codes for geographic restriction in CloudFront"
  type        = list(string)
  default     = ["US", "CA", "IN"]
}

variable "cloudfront_default_certificate" {
  description = "Whether to use the default CloudFront certificate (for HTTPS)"
  type        = bool
  default     = true
}

variable "retain_on_delete" {
  description = "Whether to retain the CloudFront distribution on Terraform destroy"
  type        = bool
  default     = false
}

variable "region" {
  description = "The AWS region in which resources will be created"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role to be assumed by Terraform"
  type        = string
}