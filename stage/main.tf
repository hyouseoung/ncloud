
module "vpc" {
    source              = "../complete-module/modules/vpc"

    vpc-name            = "stg-vpc"
    vpc-cider           = "10.0.0.0/16"
    
    public-subnet-name  = "stg-vpc-web-sub"
    public-subnet-cider = "10.0.1.0/24"
    zone                = "KR-2"

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

    /* KR1 Zone 서버 생성할 수량 명기 */
    cnt1                    = 1
    server-name1            = "stg-vpc-kr1-web-server"
    subnet1-id              = module.vpc.lb_prviate_subnet1
    private-ip1             = ["10.0.4.10", "10.0.4.11"]    
    
    /* KR2 Zone 서버 생성할 수량 명기 */
    cnt2                     = 1
    server-name2            = "stg-vpc-kr2-web-server"
    subnet2-id              = module.vpc.lb_prviate_subnet2
    private-ip2             = ["10.0.5.10", "10.0.5.11"]    

    /* 공통 */
    access_control_group_no = module.acg.acg_access_control_group_no
    login-key               = "loginkey"
}
module "lb" {
    source              = "../complete-module/modules/lb"

    count               = 1
    vpc-id              = module.vpc.lg_vpc_id
    svr-instance-id     = [module.server.az1_server[count.index].instance_no, module.server.az2_server[count.index].instance_no]
    tg-name             = "lab1-tg"
}
