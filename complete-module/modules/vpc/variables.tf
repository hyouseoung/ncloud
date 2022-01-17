/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module로 부터 입력받을 입력 값들을 관리
*/
variable "vpc-name" {
    description = "Set VPC Name"
    type    = string
}
variable "vpc-cider" {
    description = "Set VPC CIDR"
    type        = string
}
variable "public-subnet-name" {
    description = "Set Public Subnet name"
    type    = string
}
variable "public-subnet-cider" {
    description = "Set Public Subnet CIDR"
    type    = string
}
variable "zone" {
    description = "Set Availaibility Zone"
    type    = string
}
variable "nacl-name" {
    description = "Set NACL Name"
    type    = string
}
// SSH 접속을 위한 소스 IP (UCLOUD NAT)
variable "source-ip" {
    description = "source ip for ssh connect"
    type    = string
}
variable "lb-subnet-name" {
    description = "Set lb Private Subnet Name"
    type    = list(string)
}
variable "lb-subnet-cider" {
    description = "Set lb Private Subnet Cider"
    type    = list(string)
}
variable "lb-zone" {
    description = "Set lb Zone"
    type    = list(string)
}
