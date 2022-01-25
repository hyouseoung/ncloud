terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_access_control_group" "lg_acg" {
    name        = var.acg-name
    vpc_no      = var.vpc-id
}

resource "ncloud_access_control_group_rule" "lg_acg_rule" {
    access_control_group_no = ncloud_access_control_group.lg_acg.id

    inbound {
        protocol    = "ICMP"
        ip_block    = "0.0.0.0/0"
        description = "ICMP Allow ALL"
    }

    inbound {
        protocol    = "TCP"
        ip_block    = "0.0.0.0/0"
        port_range  = "80"
        description = "accept 80 port"
    }

    inbound {
        protocol    = "TCP"
        ip_block    = var.source-ip
        port_range  = "22"
        description = "accept 22 port"
    }

    inbound {
        protocol    = "TCP"
        ip_block    = "219.250.86.219/32" /* 내 로컬 PC */
        port_range  = "22"
        description = "my local pc accept 22 port"
    }
    outbound {
        protocol    = "TCP"
        ip_block    = "0.0.0.0/0" 
        port_range  = "1-65535"
        description = "accept 1-65535 port"
    }

    outbound {
        protocol    = "UDP"
        ip_block    = "0.0.0.0/0" 
        port_range  = "1-65535"
        description = "accept 1-65535 port"
    }

    outbound {
        protocol    = "ICMP"
        ip_block    = "0.0.0.0/0" 
        description = "ICMP Allow ALL"
    }
}