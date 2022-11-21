resource "aws_s3_bucket" "prv-bucket" {
    bucket = "prnv21102000"
    tags = {
    Name        = "Prnv-bucket"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.prv-bucket.id
  acl    = "private"
}