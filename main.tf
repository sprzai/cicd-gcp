provider "google" {
  project = "test-gcp"
  region  = "us-central1"
}

resource "google_cloudfunctions_function" "function" {
  name        = "mi-funcion"
  description = "Mi Cloud Function"
  runtime     = "nodejs14"

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  trigger_http = true
  entry_point  = "helloWorld"
}

resource "google_storage_bucket" "bucket" {
  name = "bucket-function-le"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./function-source.zip"
}
