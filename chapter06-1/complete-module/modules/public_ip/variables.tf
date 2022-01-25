/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module로 부터 입력받을 입력 값들을 관리
*/
variable "svr-instance-no" {
    description = "return server instance ID after server module create server"
    type    = string
}