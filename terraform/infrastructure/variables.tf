variable "resource_group_name_func_app" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_name_database_account" {
  description = "The name of the resource group"
  type        = string

}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "cosmosdb_account_name" {
  description = "The name of the cosmosdb account"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "The name of the cosmosdb database"
  type        = string
}

variable "cosmosdb_connection_string" {
  description = "The connection string of the cosmosdb account"
  type        = string
  sensitive   = true
}

variable "function_app_name" {
  description = "The name of the function app"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string

}

variable "app_service_plan_name" {
  description = "The name of the app service plan"
  type        = string
}

