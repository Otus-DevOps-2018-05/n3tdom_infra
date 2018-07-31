variable "source_ranges" {
  description = "Allowed IP"
  default     = ["0.0.0.0/0"]
  type        = "list"
}

variable enviroment {
  description = "Adds name prefix to all objects"
}
