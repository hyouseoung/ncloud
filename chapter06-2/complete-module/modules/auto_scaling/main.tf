terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}

resource "ncloud_launch_configuration" "lc" {
    name                        = "my-lc"
    server_image_product_code   = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
    server_product_code         = "SVR.VSVR.HICPU.C002.M004.NET.SSD.B050.G002"
    //init_script_no              = var.init-script-id  실행시 서버 생성하는데 시간이 걸려 LB target group에 등록이 되지 않음
    login_key_name              = var.login-key
}

resource "ncloud_auto_scaling_group" "asg" {
    name                         = "my-asg"
    launch_configuration_no      = ncloud_launch_configuration.lc.launch_configuration_no
    access_control_group_no_list = [var.access-control-group-no]
    subnet_no                    = var.subnet-no
    min_size                     = 1
    max_size                     = 3
    desired_capacity             = 2
    health_check_type_code       = "LOADB"
    target_group_list            = [var.lb-tg-list]
    zone_no_list                 = ["2"]
    wait_for_capacity_timeout    = 0
    health_check_grace_period    = 300
}

resource "ncloud_auto_scaling_policy" "policy1" {
    name                        = "add-policy"
    adjustment_type_code        = "CHANG"
    scaling_adjustment          = 1
    auto_scaling_group_no       = ncloud_auto_scaling_group.asg.auto_scaling_group_no
}

resource "ncloud_auto_scaling_policy" "policy2" {
    name                        = "sub-policy"
    adjustment_type_code        = "PRCNT"
    scaling_adjustment          = 1
    auto_scaling_group_no       = ncloud_auto_scaling_group.asg.auto_scaling_group_no
}

resource "ncloud_auto_scaling_schedule" "schedule" {
    name                    = "add-schedule"
    min_size                = 1
    max_size                = 3
    desired_capacity        = 2
    /* start_time 값은 미래로 설정되어야 함 */
    start_time              = "2022-02-26T18:00:00+0900"
    end_time                = "2023-01-18T18:00:00+0900"
    auto_scaling_group_no   = ncloud_auto_scaling_group.asg.auto_scaling_group_no
}