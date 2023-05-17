variable "region" {
  description = "value"
  type        = string
}
variable "bucket_name" {
  description = "value"
  type        = string
}
variable "cloudfront_oai_comment" {
  description = "value"
  type        = string
}
variable "s3_distribution_enabled" {
  description = "value"
  type        = bool
}
variable "versioning_enabled" {
  description = "value"
  type        = string
  default = "Disabled"
}
variable "block_public_acls" {
  description = "value"
  type        = bool
  default = false
}

variable "cache_allowed_methods" {
  description = "value"
  type        = list (string)
}
variable "cached_methods" {
  description = "value"
  type        = list (string)
}
variable "query_string" {
  description = "value"
  type        = bool
}
variable "cookies_forward" {
  description = "value"
  type        = string
}
variable "viewer_protocol_policy" {
  description = "value"
  type        = string
}
variable "restriction_type" {
  description = "value"
  type        = string
}
variable "geo_locations" {
  description = "value"
  type        = list (string)
}
variable "cloudfront_default_certificate" {
  description = "value"
  type        = bool
}
variable "retain_on_delete" {
  description = "value"
  type        = bool
}
 variable "role_arn" {
   description = " The ARN of the IAM role"
  type = string
}