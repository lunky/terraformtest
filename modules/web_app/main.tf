# modules/web_app/main.tf
resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id
  virtual_network_subnet_id = var.subnet_id
  tags                = var.tags

  app_settings = {
    "ConnectionStrings__CategorizationConnectionString" = local.connection_string_default
    "ConnectionStrings__ListingConnectionString"        = local.connection_string_default
    "ConnectionStrings__ManifestsConnectionString"      = local.connection_string_default
    "ConnectionStrings__ShelvingConnectionString"       = local.connection_string_default
    "ConnectionStrings__UsersConnectionString"          = local.connection_string_default
    "APPINSIGHTS_INSTRUMENTATIONKEY"                    = var.applicationinsights_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"             = var.applicationinsights_connection_string
    "APPLICATIONINSIGHTS_ENABLESQLQUERYCOLLECTION"      = "disabled"

    "ASPNETCORE_FORWARDEDHEADERS_ENABLED"             = "true"
    "AzureStorage__BaseUrl"                           = var.azure_storage_base_url
    "AzureStorage__ConnectionString"                  = var.azure_storage_connection_string
    "AzureStorage__ContainerName"                     = var.azure_storage_container_name
    "WEBSITE_FORWARDED_HOST_HEADER_NAME"              = "X-Forwarded-Host"
    "WEBSITE_FORWARDED_PROTO_HEADER_NAME"             = "X-Forwarded-Proto"
  }

  site_config {
    always_on = true
  }
}
