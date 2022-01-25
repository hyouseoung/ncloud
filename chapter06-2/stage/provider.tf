terraform {
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}
provider "ncloud" {
  access_key  = var.access-key
  secret_key  = var.secret-key
  region      = var.region
  support_vpc = var.support-vpc
}
