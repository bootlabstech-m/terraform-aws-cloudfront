data "aws_s3_bucket" "existing_bucket" {
  bucket = var.bucket_name
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.existing_bucket.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.origin_access.iam_arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = data.aws_s3_bucket.existing_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json

  lifecycle {
    ignore_changes = [policy]
  }
}

locals {
  s3_origin_id = "myS3Origin"
}
resource "aws_cloudfront_origin_access_identity" "origin_access" {
  comment = var.cloudfront_oai_comment
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = data.aws_s3_bucket.existing_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access.cloudfront_access_identity_path
    }


  }
  enabled = var.s3_distribution_enabled

  default_cache_behavior {
    allowed_methods  = var.cache_allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.query_string

      cookies {
        forward = var.cookies_forward
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.geo_locations
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }

  retain_on_delete = var.retain_on_delete
  lifecycle {
    ignore_changes = [
      tags,
      aliases,
      price_class,
      restrictions[0].geo_restriction[0].locations,
      viewer_certificate[0].acm_certificate_arn,
      viewer_certificate[0].cloudfront_default_certificate,
      viewer_certificate[0].minimum_protocol_version,
      viewer_certificate[0].ssl_support_method,
      origin
    ]
  }
}