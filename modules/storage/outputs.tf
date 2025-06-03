output "azurerm_storage_account_tfer--elfdevstorageaccount_id" {
  value = "${azurerm_storage_account.tfer--elfdevstorageaccount.id}"
}

output "azurerm_storage_account_tfer--elfdevstorageaccount_name" {
  value = "${azurerm_storage_account.tfer--elfdevstorageaccount.name}"
}
output "storage_blob_endpoint" {
  value = azurerm_storage_account.tfer--elfdevstorageaccount.primary_blob_endpoint
}