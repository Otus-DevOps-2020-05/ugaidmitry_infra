terraform {
  backend "gcs" {
    bucket = "bucket-ugaidmitry"
    prefix = "terraform/state"
  }
}
