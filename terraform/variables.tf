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

variable private_key {
  description = "Path to the private key used for ssh provisioning"
}

variable instance_count {
  description = "How many instances to keep"
  default     = "1"
}
