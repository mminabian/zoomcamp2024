terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.12.0"
    }
  }
}
provider "google" {
  # Configuration options
  credentials = file(var.credentials)
  project = var.project
  region  = var.region

}

resource "google_storage_bucket" "demo_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}
resource "google_bigquery_dataset" "dataset_demo" {
  dataset_id = var.bq_dataset_name
  location = var.location
}