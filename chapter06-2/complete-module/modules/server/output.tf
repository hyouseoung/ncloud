/*
    Root Module 에서 다른 Child Module을 호출하여 다른 Child Module의 입력 값으로 전달, Module간 연결
    다른 Module에게 반활할 출력 값들을 관리
*/
output "login_key" {
    value = ncloud_login_key.lg_loginkey.key_name
}