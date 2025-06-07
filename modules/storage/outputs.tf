# modules/storage/outputs.tf
output "id" {
  value = azurerm_storage_account.this.id
}
output "blob_storage_url" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

output "blob_storage_connection_string" {
  value = azurerm_storage_account.this.primary_blob_connection_string
}
