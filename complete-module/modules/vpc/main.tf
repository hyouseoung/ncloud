terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_vpc" "lg_vpc" {
    name            = var.vpc-name
    ipv4_cidr_block = var.vpc-cider
}

resource "ncloud_network_acl" "lg_nacl" {
    name            = var.nacl-name
    description     = "lg_vpc's network acl"
    vpc_no          = ncloud_vpc.lg_vpc.id
}

resource "ncloud_network_acl_rule" "lg_nacl_rule" {
    network_acl_no  = ncloud_network_acl.lg_nacl.id

    inbound {
        priority    = 0
        protocol    = "ICMP"
        rule_action = "ALLOW"
        ip_block    = "0.0.0.0/0"
    }
    
    inbound {
        priority    = 1
        protocol    = "TCP"
        rule_action = "ALLOW"
        ip_block    = "0.0.0.0/0"
        port_range  = "80"
    }

    inbound {
        priority    = 2
        protocol    = "TCP"
        rule_action = "ALLOW"
        ip_block    = var.source-ip
        port_range  = "22"
    }

    inbound {
        priority    = 197
        protocol    = "TCP"
        rule_action = "DROP"
        ip_block    = "0.0.0.0/0"
        port_range  = "22"
    }

    outbound {
        priority    = 0
        protocol    = "TCP"
        rule_action = "ALLOW"
        ip_block    = "0.0.0.0/0"
        port_range  = "1-65535"
    }

    outbound {
        priority    = 1
        protocol    = "UDP"
        rule_action = "ALLOW"
        ip_block    = "0.0.0.0/0"
        port_range  = "1-65535"
    }

    outbound {
        priority    = 2
        protocol    = "ICMP"
        rule_action = "ALLOW"
        ip_block    = "0.0.0.0/0"
    }
    
}

resource "ncloud_subnet" "lg_public_subnet1" {
    name            = var.public-subnet-name[0]
    vpc_no          = ncloud_vpc.lg_vpc.id
    subnet          = var.public-subnet-cider[0]
    zone            = var.public-zone[0]
    network_acl_no  = ncloud_network_acl.lg_nacl.id
    subnet_type     = "PUBLIC"
}

resource "ncloud_subnet" "lg_public_subnet2" {
    name            = var.public-subnet-name[1]
    vpc_no          = ncloud_vpc.lg_vpc.id
    subnet          = var.public-subnet-cider[1]
    zone            = var.public-zone[1]
    network_acl_no  = ncloud_network_acl.lg_nacl.id
    subnet_type     = "PUBLIC"
}

resource "ncloud_subnet" "lb_private_subnet1" {
    name            = var.lb-subnet-name[0]
    vpc_no          = ncloud_vpc.lg_vpc.id
    subnet          = var.lb-subnet-cider[0]
    zone            = var.lb-zone[0]
    network_acl_no  = ncloud_network_acl.lg_nacl.id
    subnet_type     = "PRIVATE"
    usage_type      = "LOADB" 
}

resource "ncloud_subnet" "lb_private_subnet2" {
    name            = var.lb-subnet-name[1]
    vpc_no          = ncloud_vpc.lg_vpc.id
    subnet          = var.lb-subnet-cider[1]
    zone            = var.lb-zone[1]
    network_acl_no  = ncloud_network_acl.lg_nacl.id
    subnet_type     = "PRIVATE"
    usage_type      = "LOADB" 
}
