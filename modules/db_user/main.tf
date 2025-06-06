resource "postgresql_role" "user" {
  name     = var.username
  login    = true
  password = var.password
}

resource "postgresql_grant" "connect" {
  database    = var.database
  role        = postgresql_role.user.name
  object_type = "database"
  privileges  = ["CONNECT"]
}
