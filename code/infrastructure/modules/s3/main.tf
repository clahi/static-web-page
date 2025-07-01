resource "aws_s3_bucket" "web_bucket" {
#   bucket = "my-web-bucket-adlf34"
  bucket = var.bucket_name

  tags = {
    Name = "My web bucket"
  }
}

resource "aws_s3_bucket_policy" "my-static-website-policy" {
  bucket = aws_s3_bucket.web_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
  depends_on = [
    aws_s3_bucket_ownership_controls.control,
    aws_s3_bucket_public_access_block.public_access,
  ]
}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path}../../../Front-end"
}

resource "aws_s3_object" "FrontEndFolder" {
  bucket = aws_s3_bucket.web_bucket.id

  for_each = module.template_files.files
  key = each.key
  content_type = each.value.content_type
  source = each.value.source_path
  content = each.value.content
  etag = each.value.digests.md5
}