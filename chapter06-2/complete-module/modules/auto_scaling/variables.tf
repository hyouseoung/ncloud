/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module로 부터 입력받을 입력 값들을 관리
*/
variable "login-key" {
    description = "Set KR1 Zone Server Name"
    type        = string
}
variable "subnet-no" {
    description = "Return Public Subent No after VPC module create public subnet"
    type        = string
}
variable "access-control-group-no" {
    description = "Return acg after acg module create acg"
    type        = string
}
variable "depends-on-lb-tg-list" {
    description = "Return Group number list of Load Balancer after lb module create lb"
    type        = string
}
variable "init-script-id" {
    description = "Return init script id after init_script module create init"
    type    = string
}