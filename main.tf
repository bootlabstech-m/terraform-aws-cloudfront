resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
    lifecycle {
    ignore_changes = [tags]
  }

}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning_enabled
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_acls
  ignore_public_acls      = var.block_public_acls
  restrict_public_buckets = var.block_public_acls
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
locals {
  s3_origin_id = "myS3Origin"
}
resource "aws_cloudfront_origin_access_identity" "origin_access" {
  comment = var.cloudfront_oai_comment
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
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
      restrictions[0].geo_restriction.locations,
      viewer_certificate.acm_certificate_arn,
      viewer_certificate.cloudfront_default_certificate,
      viewer_certificate.minimum_protocol_version,
      viewer_certificate.ssl_support_method,
      origin,
     ]
  }
}