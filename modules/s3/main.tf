# S3 Bucket Resource
resource "aws_s3_bucket" "claudebucket" {
  bucket = var.bucket # Using the bucket variable

  tags = {
    Name        = "Claude bucket"
    Environment = var.environment
  }
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "claudebucket" {
  bucket = aws_s3_bucket.claudebucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 Bucket ACL
resource "aws_s3_bucket_acl" "claudebucket" {
  depends_on = [aws_s3_bucket_ownership_controls.claudebucket]
  bucket     = aws_s3_bucket.claudebucket.id
  acl        = "private"
}

# S3 Bucket Logging Configuration
resource "aws_s3_bucket_logging" "claudebucket" {
  bucket        = aws_s3_bucket.claudebucket.id
  target_bucket = aws_s3_bucket.claudebucket.id
  target_prefix = "log/"
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "claude_versioning" {
  bucket = aws_s3_bucket.claudebucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# KMS Key Resource
resource "aws_kms_key" "claudekey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.aws_kms_key # Using the KMS key deletion window variable
}

# S3 Bucket Server-Side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "claudebucket" {
  bucket = aws_s3_bucket.claudebucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.claudekey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# S3 Bucket Lifecycle Configuration
resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.claudebucket.id

  rule {
    id = "log"

    expiration {
      days = 90
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "tmp"

    filter {
      prefix = "tmp/"
    }

    expiration {
      date = "2024-10-13T00:00:00Z"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "claudebucket" {
  bucket = aws_s3_bucket.claudebucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}