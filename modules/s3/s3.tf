resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.name

  tags = {
    Name        = "${var.name}-${var.environment}-public-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_enable_public" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "s3_bucket_public_policy" {

  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id

  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::${var.name}/*"
        }
    ]
}
POLICY
}