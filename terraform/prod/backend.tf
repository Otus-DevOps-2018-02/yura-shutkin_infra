terraform {
  backend "gcs" {
    bucket  = "storage-bucket-test-615c5b82c33a352b-1"
    prefix  = "terraform/prod"
  }
}
