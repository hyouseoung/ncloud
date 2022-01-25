/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module에게 반활할 출력 값들을 관리
*/
output "acg_access_control_group_no" {
    value = ncloud_access_control_group.lg_acg.access_control_group_no
}