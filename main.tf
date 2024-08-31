provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloudfunctions_function" "function" {
  name        = "mi-funcion-${var.project_id}"
  description = "Mi Cloud Function"
  runtime     = "nodejs14"

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  trigger_http = true
  entry_point  = "helloWorld"

  available_memory_mb   = 128
  source_repository     = {}
}

resource "google_storage_bucket" "bucket" {
  name     = "bucket-para-mi-funcion-${var.project_id}"
  location = var.region
  force_destroy = true
}

resource "google_storage_bucket_object" "archive" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = var.function_zip_path
}

variable "project_id" {
  description = "El ID del proyecto de GCP"
  type        = stringç
  default     = "test-gcp-434200"
}

variable "region" {
  description = "La región de GCP para desplegar los recursos"
  type        = string
  default     = "us-central1"
}

variable "function_zip_path" {
  description = "La ruta al archivo ZIP de la función"
  type        = string
  default     = "./function-source.zip"
}