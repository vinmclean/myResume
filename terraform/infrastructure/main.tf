
resource "azurerm_resource_group" "fun_app_rg" {
  name     = var.resource_group_name_func_app
  location = "eastus2"
}

resource "azurerm_resource_group" "database_account_rg" {
  name     = var.resource_group_name_database_account
  location = var.location
}

resource "azurerm_cosmosdb_account" "database_account" {
  name                = var.cosmosdb_account_name
  location            = "eastus2"
  resource_group_name = var.resource_group_name_database_account
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  tags = {
    defaultExperience = "Core (SQL)"
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    failover_priority = 0
    location          = "eastus2"
    zone_redundant    = false
  }
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = var.cosmosdb_database_name
  resource_group_name = var.resource_group_name_database_account
  account_name        = azurerm_cosmosdb_account.database_account.name
}

resource "azurerm_storage_account" "func_app_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.fun_app_rg.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  location            = "eastus"
  resource_group_name = azurerm_resource_group.fun_app_rg.name


  sku_name = "Y1"
  os_type  = "Linux"
}

resource "azurerm_linux_function_app" "py_func_app" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.fun_app_rg.name
  service_plan_id            = azurerm_service_plan.app_plan.id
  storage_account_name       = azurerm_storage_account.func_app_storage_account.name
  storage_account_access_key = azurerm_storage_account.func_app_storage_account.primary_access_key

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = "74c873fd-0b5a-4938-bab7-2d39d91e62d1"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=74c873fd-0b5a-4938-bab7-2d39d91e62d1;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/"
    "AzureCosmosDBConnectionString"         = var.cosmosdb_connection_string
    "ENABLE_ORYX_BUILD"                     = "1"
    "AzureWebJobsFeatureFlags"              = "EnableWorkerIndexing"
    "FUNCTIONS_WORKER_RUNTIME"              = "python"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"        = "1"
  }

  site_config {
    cors {
      allowed_origins = [
        "https://portal.azure.com",
        "https://www.vincentmclean.com",
      ]
      support_credentials = true
    }
  }
}