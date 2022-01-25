terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_lb_target_group" "lb_tg_group" {
    name        = var.tg-name
    vpc_no      = var.vpc-id 
    protocol    = "HTTP"
    target_type = "VSVR"
    port        = 80
    description = "lb test"
    health_check {
        protocol        = "HTTP"
        http_method     = "HEAD"
        port            = 80
        url_path        = "/"
        cycle           = 30
        up_threshold    = 2
        down_threshold  = 2
    }
    algorithm_type = "RR"
}

resource "ncloud_lb_target_group_attachment" "lb_tg_group_attach" {
    target_group_no = ncloud_lb_target_group.lb_tg_group.target_group_no
    target_no_list  = var.svr-instance-no
}
resource "ncloud_lb" "lb" {
    name            = var.lb-name
    network_type    = "PUBLIC"
    type            = "APPLICATION"
    subnet_no_list  = var.lb-subnet
}
resource "ncloud_lb_listener" "lb_listener" {
    load_balancer_no = ncloud_lb.lb.load_balancer_no
    protocol         = "HTTP"
    port             = 80
    target_group_no  = ncloud_lb_target_group.lb_tg_group.target_group_no
}