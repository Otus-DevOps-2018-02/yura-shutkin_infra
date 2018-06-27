provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.1.1"
  name    = ["storage-bucket-test-${random_id.server.hex}-1", "storage-bucket-test-${random_id.server.hex}-2"]
}

resource "random_id" "server" {
  byte_length = 8
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
