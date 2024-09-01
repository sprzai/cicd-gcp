provider "google" {
  project = "test-gcp-434200"
  region  = "us-central1"
}

resource "google_storage_bucket" "func_bucket" {
  name          = "bucket-function-le"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "func_src" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.func_bucket.name
  source = "function-source.zip"
}

resource "google_cloudfunctions_function" "func" {
  name                  = "funcHello"
  runtime               = "nodejs20"
  description           = "some function"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.func_bucket.name
  source_archive_object = google_storage_bucket_object.func_src.name
  trigger_http          = true # 2
  entry_point           = "helloWorld"
}

resource "google_cloudfunctions_function_iam_member" "pub_access" {
  region         = google_cloudfunctions_function.func.region
  cloud_function = google_cloudfunctions_function.func.name
  role           = "roles/invokeFunctions"
  member         = "allUsers"
}