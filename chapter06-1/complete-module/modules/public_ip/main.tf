terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_public_ip" "public_ip" {
    server_instance_no      = var.svr-instance-no
}