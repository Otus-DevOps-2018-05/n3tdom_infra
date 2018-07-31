provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  enviroment       = "${var.enviroment}"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  db_address       = "${module.db.db_internal_ip}"
  app_provision    = "${var.app_provision}"
  private_key_path = "${var.private_key_path}"
}

module "db" {
  source          = "../modules/db"
  enviroment      = "${var.enviroment}"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  enviroment    = "${var.enviroment}"
  source_ranges = ["0.0.0.0/0"]
}
