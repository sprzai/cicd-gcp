resource "google_storage_bucket" "func_bucket" {
  name = "bucket-function-le2"
}

resource "google_storage_bucket_object" "func_src" {
  name = "index.zip"
  bucket = google_storage_bucket.func_bucket.name
  source = "function-source.zip"
}

resource "google_cloudfunctions_function" "func" {
  name = "func"
  runtime = "nodejs14"
  description = "some function"
  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.func_bucket.name
  source_archive_object = google_storage_bucket_object.func_src.name
  trigger_http = true
  entry_point = "helloWorld"
}

resource "google_cloudfunctions_function_iam_member" "pub_access" {
  region = google_cloudfunctions_function.func.region
  cloud_function = google_cloudfunctions_function.func.name
  role = "roles/invokeFunctions"
  member = "allUsers"
}