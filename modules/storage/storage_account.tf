resource "azurerm_storage_account" "tfer--elfdevstorageaccount" {
  access_tier                     = "Hot"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = "true"

  blob_properties {
    change_feed_enabled           = "false"
    change_feed_retention_in_days = "146000"

    container_delete_retention_policy {
      days = "7"
    }

    delete_retention_policy {
      days                     = "7"
      permanent_delete_enabled = "false"
    }

    last_access_time_enabled = "false"
    versioning_enabled       = "false"
  }

  cross_tenant_replication_enabled  = "false"
  default_to_oauth_authentication   = "false"
  dns_endpoint_type                 = "Standard"
  https_traffic_only_enabled        = "true"
  infrastructure_encryption_enabled = "false"
  is_hns_enabled                    = "false"
  large_file_share_enabled          = "true"
  local_user_enabled                = "true"
  location                          = "westus2"
  min_tls_version                   = "TLS1_2"
  name                              = "elfdevstorageaccount2"

  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Allow"
    ip_rules       = ["67.191.173.49"]
  }

  nfsv3_enabled                 = "false"
  public_network_access_enabled = "true"
  queue_encryption_key_type     = "Service"

  queue_properties {
    hour_metrics {
      enabled               = "false"
      include_apis          = "false"
      retention_policy_days = "365"
      version               = "1.0"
    }

    logging {
      delete                = "false"
      read                  = "false"
      retention_policy_days = "365"
      version               = "1.0"
      write                 = "false"
    }

    minute_metrics {
      enabled               = "false"
      include_apis          = "false"
      retention_policy_days = "365"
      version               = "1.0"
    }
  }

  resource_group_name = var.resource_group_name
  sftp_enabled        = "false"

  share_properties {
    retention_policy {
      days = "7"
    }
  }

  shared_access_key_enabled = "true"
  table_encryption_key_type = "Service"
}
