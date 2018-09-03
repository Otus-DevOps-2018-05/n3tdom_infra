terraform {
  backend "gcs" {
    bucket = "n3tdom-stage"
    prefix = "tfstate"
  }
}
