/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module에게 반환할 출력 값들을 관리
*/
output "lg_vpc_id" {
    value = ncloud_vpc.lg_vpc.id
}
output "lg_public_subnet1" {
    value = ncloud_subnet.lg_public_subnet1.id
}
output "lg_public_subnet2" {
    value = ncloud_subnet.lg_public_subnet2.id
}
output "lb_prviate_subnet1" {
    value = ncloud_subnet.lb_private_subnet1.id
}
output "lb_prviate_subnet2" {
    value = ncloud_subnet.lb_private_subnet2.id
}
