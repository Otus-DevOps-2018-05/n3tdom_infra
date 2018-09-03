variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh provisioning"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable enviroment {
  description = "Adds name prefix to all objects"
}

variable db_address {
  description = "Db instance ip"
}

variable app_provision {
  description = "Provision instance with app"
  default     = "true"
}
