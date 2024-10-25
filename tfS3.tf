# #-------------------------------------------------------------------------------------
# # Bucket Artefatos Jobs Glue
# #-------------------------------------------------------------------------------------
# resource "aws_s3_bucket" "artefact_lambda" {
#   bucket = "${var.bucket_artefact_lambda}-${local.account_id}"
# }

# resource "aws_s3_bucket_versioning" "artefact_lambda_versioning" {
#   bucket = aws_s3_bucket.artefact_lambda.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }


# ## Copia Script da Lambda para o Bucket artefact_lambda
# resource "aws_s3_object" "artefact_glue" {
#   depends_on = [aws_s3_bucket_versioning.artefact_lambda_versioning]
#   for_each   = fileset("script/", "**")
#   bucket     = aws_s3_bucket.artefact_glue.id
#   key        = "script/${each.value}"
#   source     = "script/${each.value}"
#   etag       = filemd5("script/${each.value}")
# }
