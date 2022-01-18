variable "vpc-id" {
    description = "return vpc id after vpc module create vpc"
    type    = string
}
variable "tg-name" {
    description = "Set lb target group name"
    type    = string
}
variable "svr-instance-no" {
    description = "return server instance ID after server module create server"
    type    = list(string)
}