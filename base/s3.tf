

resource "aws_s3_bucket" "cstar_jobs" {
  bucket = "${var.project_name}-jobs-${data.aws_caller_identity.current.account_id}${var.staging_suffix}"
  acl = "private"
  versioning {
    enabled = true
  }
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "cstar_jobs" {
  bucket = aws_s3_bucket.cstar_jobs.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# --- DG Jobs --- END

# --- DG Events --- BEGIN

resource "aws_s3_bucket" "events" {
  bucket = "${var.project_name}-events-${data.aws_caller_identity.current.account_id}${var.staging_suffix}"
  acl = "private"
  versioning {
    enabled = true
  }
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "events" {
  bucket = aws_s3_bucket.events.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# --- DG Events --- END

# --- DG Glue Temp --- BEGIN

resource "aws_s3_bucket" "glue_temp" {
  bucket = "${var.project_name}-glue-temp-${data.aws_caller_identity.current.account_id}${var.staging_suffix}"
  acl = "private"
  versioning {
    enabled = false
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    id                                     = "delete-old-files-7d"
    tags                                   = local.tags
    expiration {
      days                         = 7
      expired_object_delete_marker = false
    }
  }
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "glue_temp" {
  bucket = aws_s3_bucket.glue_temp.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# --- DG Glue Temp --- END

