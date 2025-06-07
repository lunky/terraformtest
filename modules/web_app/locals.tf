locals {
  connection_string_default = "Host=${var.postgres_host};Port=5432;Database=${var.database_name};username=${var.database_user};password=${var.database_password};Include Error Detail=true"
}
