terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_login_key" "lg_loginkey" {
    key_name        = var.login-key
}

resource "ncloud_server" "az1_server" {
    /* 입력 받은 IP 수량 만큼 서버 생성 하기 위해 count 변수 추가 */
    count                       = length(var.private-ip1)
    name                        = "${var.server-name1}${count.index+1}"
    subnet_no                   = var.subnet1-id
    server_image_product_code   = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
    login_key_name              = ncloud_login_key.lg_loginkey.key_name

    network_interface {
        network_interface_no    = ncloud_network_interface.az1_server_nic[count.index].id
        order                   = 0
    }
}

resource "ncloud_network_interface" "az1_server_nic" {
    count                       = length(var.private-ip1)
    name                        = "${var.server-name1}${count.index+1}-nic"
    subnet_no                   = var.subnet1-id
    private_ip                  = var.private-ip1[count.index]
    access_control_groups       = [var.access_control_group_no]
}

resource "ncloud_server" "az2_server" {
    /* 입력 받은 IP 수량 만큼 서버 생성 하기 위해 count 변수 추가 */
    count                       = length(var.private-ip2)
    name                        = "${var.server-name2}${count.index+1}"
    subnet_no                   = var.subnet2-id
    server_image_product_code   = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
    login_key_name              = ncloud_login_key.lg_loginkey.key_name

    network_interface {
        network_interface_no    = ncloud_network_interface.az2_server_nic[count.index].id
        order                   = 0
    }
}

resource "ncloud_network_interface" "az2_server_nic" {
    count                       = length(var.private-ip2)
    name                        = "${var.server-name2}${count.index+1}-nic"
    subnet_no                   = var.subnet2-id
    private_ip                  = var.private-ip2[count.index]
    access_control_groups       = [var.access_control_group_no]
}

