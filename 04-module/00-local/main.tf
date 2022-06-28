module "website_s3_bucket" {
  source = "./s3-static-website"

  bucket_name = "s3-static-website-rajesh"
  tags = {
    Terraform   = "true"
  }
}