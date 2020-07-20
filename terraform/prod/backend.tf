terraform {
  backend "gcs" {
    bucket = "bucket-dmitryugai"
    prefix = "terraform/state"
  }
}
