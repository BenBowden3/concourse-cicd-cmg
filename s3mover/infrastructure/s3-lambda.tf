data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "../lambda/s3_mover/"
  output_path = "../lambda/s3_mover/dist/function.zip"
}

resource "aws_lambda_function" "s3_mover" {
  filename      = data.archive_file.function_archive.output_path
  function_name = "s3_mover_cmg"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  source_code_hash = data.archive_file.function_archive.output_sha

  runtime     = "nodejs12.x"
  timeout     = "90"
  memory_size = local.lambda_memory

  # environment {
  #   variables = {
  #     "REGION" = var.region,
  #     "BUCKET_NAME" = aws_bucket.aws_s3_destination_bucket.name
  #   }
  # }


# s3-mover lambda that is triggered when something is added to source bucket.
# resource "aws_lambda_event_source_mapping" "source" {
#  event_source_arn  = data.aws_s3_bucket_source.arn
#  function_name     = data.s3-mover.arn
# }
}
resource "aws_lambda_permission" "allow_bucket1" {
  statement_id  = "AllowExecutionFromS3Bucket1"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_mover.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.aws_s3_source_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.aws_s3_source_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_mover.arn
    events              = ["s3:ObjectCreated:*"]
    #filter_prefix       = "file-prefix"
    #filter_suffix       = "file-extension"
    }
  
    
}