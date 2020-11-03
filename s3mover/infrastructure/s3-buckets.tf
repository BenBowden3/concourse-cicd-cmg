resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "s3-mover-code-${var.uniqueid}"
}

resource "aws_s3_bucket" "aws_s3_source_bucket" {
  bucket = "cmg-test-one-${var.uniqueid}"
}

resource "aws_s3_bucket" "aws_s3_destination_bucket" {
  bucket = "cmg-test-two-${var.uniqueid}"
}


output "arn" {
  value = aws_s3_bucket.aws_s3_source_bucket.arn
  
}
