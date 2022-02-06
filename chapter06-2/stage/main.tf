
module "vpc" {
    source              = "../complete-module/modules/vpc"

    vpc-name            = "stg-vpc"
    vpc-cider           = "10.0.0.0/16"
    
    public-subnet-name  = ["stg-vpc-web-sub1", "stg-vpc-web-sub2"]
    public-subnet-cider = ["10.0.2.0/24", "10.0.3.0/24"]
    public-zone         = ["KR-1", "KR-2"]

    nacl-name           = "stg-vpc-web-nacl"
    source-ip           = "27.122.140.10/32"

    lb-subnet-name      = ["stg-vpc-lb-sub1", "stg-vpc-lb-sub2"]
    lb-subnet-cider     = ["10.0.4.0/24", "10.0.5.0/24"]
    lb-zone             = ["KR-1", "KR-2"]
}
module "acg" {
    source              = "../complete-module/modules/acg"

    acg-name            = "stg-vpc-acg"
    vpc-id              = module.vpc.lg_vpc_id
    source-ip           = "27.122.140.10/32"
}
module "server" {
    source                  = "../complete-module/modules/server"

    login-key               = "loginkey3"
}
module "init_script" {
    source              = "../complete-module/modules/init_script"

    script-name         = "init-script"
}
module "lb" {
    source              = "../complete-module/modules/lb"

    /* target group 생성 정보 */
    tg-name             = "stg-tg"
    vpc-id              = module.vpc.lg_vpc_id

    /* LB 생성 정보 */
    lb-name             = "stg-vpc-lb3"
    lb-subnet           = [module.vpc.lb_subnet1_no, module.vpc.lb_subnet2_no]

    /* asg에서 생성한 인스턴스 No 리스트를 전달 */
    instance-no-list    = module.auto_scaling.asg_instance_no
}

module "public_ip" {
    source              = "../complete-module/modules/public_ip"
}

module "auto_scaling" {
    source                  = "../complete-module/modules/auto_scaling"

    init-script-id          = module.init_script.init
    subnet-no               = module.vpc.lg_public_subnet2
    login-key               = module.server.login_key
    access-control-group-no = module.acg.acg_access_control_group_no
    lb-tg-list              = module.lb.lb_tg_no
}

