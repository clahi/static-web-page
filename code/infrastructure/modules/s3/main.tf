resource "aws_s3_bucket" "web_bucket" {
#   bucket = "my-web-bucket-adlf34"
  bucket = var.bucket_name

  tags = {
    Name = "My web bucket"
  }
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