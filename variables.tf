variable "bucket_name" {
  description = "Name of the existing S3 bucket to be used as CloudFront origin"
  type        = string
}

variable "cloudfront_oai_comment" {
  description = "Comment for the CloudFront Origin Access Identity"
  type        = string
  default     = "Test CloudFront OAI"
}

variable "s3_distribution_enabled" {
  description = "Enable or disable the CloudFront distribution"
  type        = bool
  default     = true
}

variable "cache_allowed_methods" {
  description = "HTTP methods allowed by CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "HTTP methods cached by CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "query_string" {
  description = "Whether CloudFront forwards query strings to S3"
  type        = bool
  default     = false
}

variable "cookies_forward" {
  description = "How CloudFront forwards cookies (none | whitelist | all)"
  type        = string
  default     = "none"
}

variable "viewer_protocol_policy" {
  description = "Viewer protocol policy (allow-all | redirect-to-https | https-only)"
  type        = string
}

variable "restriction_type" {
  description = "Geo restriction type (none | whitelist | blacklist)"
  type        = string
}

variable "geo_locations" {
  description = "Country codes for CloudFront geo restriction"
  type        = list(string)
  default     = ["US", "CA", "IN"]
}

variable "cloudfront_default_certificate" {
  description = "Use CloudFront default SSL certificate"
  type        = bool
  default     = true
}

variable "retain_on_delete" {
  description = "Retain CloudFront distribution on destroy"
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