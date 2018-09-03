variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-north1"
}

variable disk_image {
  description = "Disk image"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Zone"
}

variable private_key_path {
  description = "Path to the private key used for ssh provisioning"
}

variable instance_count {
  description = "How many instances to keep"
  default     = "1"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable source_ranges {
  description = "Allow IP"
  type        = "list"
}

variable enviroment {
  description = "Adds name prefix to all objects"
}

variable app_provision {
  description = "Provision instance with app"
  default     = "true"
}
