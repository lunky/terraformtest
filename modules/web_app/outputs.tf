# modules/web_app/outputs.tf
output "url" {
  value = azurerm_linux_web_app.this.default_hostname
}
 
