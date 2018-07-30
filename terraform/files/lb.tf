# Пояснения
# self_link = The URI of the created resource
# google_compute_instance.app.*.self_link = if the resource has a count attribute set, address atrributes of all such resources

# gcp > compute > health checks
# https://www.terraform.io/docs/providers/google/r/compute_health_check.html
resource "google_compute_http_health_check" "default" {
  name = "reddit-check"
}

# gcp > target pools
# https://www.terraform.io/docs/providers/google/r/compute_target_pool.html
resource "google_compute_target_pool" "default" {
  name = "reddit-pool"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
}

# gcp > forwarding rules
# https://www.terraform.io/docs/providers/google/d/datasource_compute_forwarding_rule.html
resource "google_compute_forwarding_rule" "default" {
  name       = "reddit-forward"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "9292"
}
