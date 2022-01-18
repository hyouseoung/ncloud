/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module로 부터 입력받을 입력 값들을 관리
*/
variable "server-name1" {
    description = "Set KR1 Zone Server Name"
    type    = string
}
variable "server-name2" {
    description = "Set KR2 Zone Server Name"
    type    = string
}
variable "subnet1-id" {
    description = "vpc module create KR1 subnet and return subnet id"
    type    = string
}
variable "subnet2-id" {
    description = "vpc module create KR2 subnet and return subnet id"
    type    = string
}
variable "private-ip1" {
    description = "Private IP in VPC KR1"
    type    = list(string)
}
variable "private-ip2" {
    description = "Private IP in VPC KR2"
    type    = list(string)
}
variable "access_control_group_no" {
    description = "Return acg after acg module create acg"
    type    = string
}
variable "login-key" {
    description = "login key for connect server"
    type    = string
}