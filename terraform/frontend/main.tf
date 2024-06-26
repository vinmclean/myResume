resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  account_tier             = var.account_tier
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_replication_type = "RAGRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = {
    ms-resource-usage = "azure-cloud-shell"
  }
}

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.cdn_profile_name
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"

}

resource "azurerm_cdn_endpoint" "endpoint" {
  name                = var.cdn_endpoint_name
  profile_name        = var.cdn_profile_name
  location            = "global"
  resource_group_name = var.resource_group_name

  origin {
    name       = var.cdn_endpoint_origin_name
    host_name  = var.cdn_endpoint_origin_host_name
    https_port = 443
  }

  is_compression_enabled = true
  origin_host_header     = "storagecrchallenge.z13.web.core.windows.net"

  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1
    request_scheme_condition {
      match_values     = ["HTTP"]
      negate_condition = false
      operator         = "Equal"
    }

    url_redirect_action {
      protocol      = "Https"
      redirect_type = "Found"
    }
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "custom-domain" {
  name            = var.custom_domain_name
  cdn_endpoint_id = azurerm_cdn_endpoint.endpoint.id
  host_name       = var.custom_domain_host_name

  lifecycle {
    # Ignoring changes to `cdn_endpoint_id` due to a case sensitivity issue with Azure's API.
    # Terraform considers changes in case (e.g., "resourceGroups" vs. "resourcegroups") as a need to recreate resources,
    # which is not necessary for Azure resources as Azure's API is case-insensitive.
    # This prevents unnecessary recreation of the custom domain resource.
    ignore_changes = [cdn_endpoint_id]
  }

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}
