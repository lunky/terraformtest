resource "azurerm_linux_web_app" "tfer--elf-web-linux" {
  name                = "elf-web-linux"
  resource_group_name = "RG-Initial"
  location            = "westus2"
  service_plan_id     = azurerm_service_plan.elf_service_plan.id


  app_settings = {
    ASPNETCORE_FORWARDEDHEADERS_ENABLED = "true"
    AzureStorage__BaseUrl               = var.storage_blob_endpoint
    AzureStorage__ConnectionString      = var.storage_connection_string
    AzureStorage__ContainerName         = "images"
    WEBSITE_FORWARDED_HOST_HEADER_NAME  = "X-Forwarded-Host"
    WEBSITE_FORWARDED_PROTO_HEADER_NAME = "X-Forwarded-Proto"
  }

  connection_string {
    name  = "CategorizationConnectionString"
    type  = "Custom"
    value = var.db_connection_string
  }

  connection_string {
    name  = "ListingConnectionString"
    type  = "Custom"
    value = var.db_connection_string
  }

  connection_string {
    name  = "ManifestsConnectionString"
    type  = "Custom"
    value = var.db_connection_string
  }

  connection_string {
    name  = "UsersConnectionString"
    type  = "Custom"
    value = var.db_connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"  # Changed to supported version
    }
    
    always_on              = false
    ftps_state            = "FtpsOnly"
    http2_enabled         = false
    minimum_tls_version   = "1.2"
    use_32_bit_worker     = true
    vnet_route_all_enabled = false
    websockets_enabled    = false

    ip_restriction {
      action      = "Allow"
      name        = "Front Door Rules"
      priority    = 1
      service_tag = "AzureFrontDoor.Backend"
    }
  }

  logs {
    application_logs {
      file_system_level = "Off"
    }

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }

    detailed_error_messages = false
    failed_request_tracing = false
  }

  https_only              = true
  client_affinity_enabled = false
  client_certificate_enabled = false
  client_certificate_mode = "Required"
}