terraform {
  backend "s3" {
    bucket = "trial-angeline"            # your existing bucket
    key    = "C:/Users/Admin/OneDrive/Documents/GitHub/assignment2_3/terraform.tfstate"
    region = "us-east-1"                          # set to the bucket's region
    encrypt = true                                # SSE-S3 at rest
    # kms_key_id = "arn:aws:kms:REGION:ACCOUNT:key/xxxx"  # optional: SSE-KMS instead
    # dynamodb_table = "tf-locks"                 # omit when not using locking
  }
}
