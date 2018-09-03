terraform {
  backend "gcs" {
    bucket = "n3tdom-prod"
    prefix = "tfstate"
  }
}
