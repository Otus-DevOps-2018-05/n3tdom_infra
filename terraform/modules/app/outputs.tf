output "app_external_ip" {
  #google_compute_instance.app = тип ресурса
  #все что после первой точки - имя ресурса (.network_interface.0.access_config.0.assigned_nat_ip)
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.assigned_nat_ip}"
}
