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