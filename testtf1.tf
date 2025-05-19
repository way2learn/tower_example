terraform {
   providers {
      onefuse = {
        source = "CloudBoltSoftware/onefuse"
        version = ">= 1.50.0"
      }
   }
   required_version = ">= 0.13"
}

provider "onefuse" {
  scheme     = "https"
  address    = "10.133.121.200"
  port       = "443"
  user       = "admin"
  password   = "admin"
  verify_ssl = false
}

data "onefuse_naming_policy" "namingPolicy" {
  name = "infra_naming"
}

resource "onefuse_naming" "customName" {
  naming_policy_id        = data.onefuse_naming_policy.naming_policy.id
  workspace_id            = "/api/v3/onefuse/workspaces/2/"
  template_properties     = {}
  dns_suffix              = "example.com"
}

output "name" {
  value = onefuse_naming.customName.name
}

output "dns_suffix" {
  value = onefuse_naming.customName.dns_suffix
}
