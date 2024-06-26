variable "resource_group_name" {
  type = string
  description = "The name of the resource group"
  
}

variable "location" {
  type = string
  description = "The location of the resource group"
}

variable "storage_account_name" {
  type = string
  description = "The name of the storage account"
}

variable "account_tier" {
  type = string
  description = "The tier of the storage account"
  default = "Standard"
}

variable "cdn_profile_name" {
  type = string
  description = "The name of the CDN profile"
  
}

variable "cdn_endpoint_name" {
  type = string
  description = "The name of the CDN endpoint"
  
}


variable "cdn_endpoint_origin_name" {
  type = string
  description = "The name of the CDN endpoint origin"
  
}

variable "cdn_endpoint_origin_host_name" {
  type = string
  description = "The host name of the CDN endpoint origin"
  
}

variable "custom_domain_name" {
  type = string
  description = "The name of the custom domain"
  
}

variable "custom_domain_host_name" {
  type = string
  description = "The host name of the custom domain"
  
}
