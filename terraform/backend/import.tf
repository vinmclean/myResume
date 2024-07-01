import {
  to = azurerm_resource_group.fun_app_rg
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/rgMyResume"
}

import {
  to = azurerm_resource_group.database_account_rg
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/cloudapi_backend"
}

import {
  to = azurerm_cosmosdb_account.database_account
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/cloudapi_backend/providers/Microsoft.DocumentDB/databaseAccounts/azureresumechallenge"
}

import {
  to = azurerm_cosmosdb_sql_database.database
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/cloudapi_backend/providers/Microsoft.DocumentDB/databaseAccounts/azureresumechallenge/sqlDatabases/resumecounter"
}

import {
  to = azurerm_storage_account.func_app_storage_account
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/rgMyResume/providers/Microsoft.Storage/storageAccounts/resumefuncstorage"
}

import {
  to = azurerm_service_plan.app_plan
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/rgMyResume/providers/Microsoft.Web/serverFarms/ASP-rgMyResume-9bad"
}

import {
  to = azurerm_linux_function_app.function_app
  id = "/subscriptions/5e34105e-5c80-4a2c-92e9-6e92450e588a/resourceGroups/rgMyResume/providers/Microsoft.Web/sites/VincentResumeProject"
}