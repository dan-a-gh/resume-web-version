terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }
}

provider "aws" {}

resource "aws_s3_bucket" "resume" {
  bucket        = "resume.danielallison.dev"
  force_destroy = true
}

resource "aws_s3_bucket_object" "app" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.resume.id
  content      = file("./index.html")
  content_type = "text/html"
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.resume.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "resume-website-config" {
  bucket = aws_s3_bucket.resume.bucket

  index_document {
    suffix = "index.html"
  }
}


