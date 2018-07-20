 value: "
 naskaoshu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChXWvXygo/SWQyT1axH5dhbtb6vfCAYma10zEQPbfsjkpDJSAux/QxSYAs7yerv+o+LYTbuZmW1VOGruiKQetXC0TeShLBmZtQkrtz0T64QKkHz0EKZ0hePFthRjGgZEYghEjaJO1bq7zQloihz6Ph7ZRaEQWK5e6CeGNz5lGILpi29lsAmOLjBH3tw0BgyV6fNUhhzBTDzp4iSmjxTa2iCiI0SOWhucCYzVaNgK+kdfACRQF19aT7Nhplq52OgpY5CC5c+nVvj4AF3vQhiuUAW8LfP9gy4rF1wtxcLrMiS6nTOOrX1MmbnyfsWI5pq3bvhdyOfnanKGsaSDBT4JcH google-ssh {\"userName\":\"naskaoshu@gmail.com\",\"expireOn\":\"2018-06-29T14:15:02+0000\"}\n
 
 naskaoshu:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEI5XPyt74V2MSygkyfkXDRQcubgxMDtaczpduq+iVPwVaYI5Re4TeLxENFALts4xdmnGhxU7jfIEI1H8RwEQ2M= google-ssh {\"userName\":\"naskaoshu@gmail.com\",\"expireOn\":\"2018-06-29T14:14:52+0000\"}\n
 
 n3tdom:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWYcJTjstQJICazA8F7nG5boM/haLFXsPF6wl4fE6mtz0nlaOryb/S4k8yo5M6Cyzy1Qrfc3GVq8mCYlqnkYwZ32KZVevxf2u5ZkwQUfO9Q6QzRObwbNd1ZqffaIUX8fy5NRa7n0DBs5JW6JLmOK7jiAFDWLMcll/bS8boOblpdNd3B7+tQdR9wz5gWB/LWC1V54WuSXwyYis3xv1cdXO7viOA8gZCRV8YDEQkRPcuc8NNMDRWN4Ub4VAmH5S3PMKbkLzNLymaxSG3x1sRZgGpbsfeOm5D9rRPfqG1dFyRVrDLYn8FVGPwdQW+p8HWQtwuj0hEPRugTDIyH9Q1+2DZ n3tdom" 
 
 
 => "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}"





#SSH-ключи
resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}"
}