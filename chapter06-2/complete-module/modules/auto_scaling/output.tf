/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module에게 반활할 출력 값들을 관리
*/
output "asg_instance_no" {
    value = ncloud_auto_scaling_group.asg.server_instance_no_list
}