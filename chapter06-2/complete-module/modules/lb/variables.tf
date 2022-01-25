variable "vpc-id" {
    description = "return vpc id after vpc module create vpc"
    type    = string
}
variable "tg-name" {
    description = "Set lb target group name"
    type    = string
}
variable "instance-no-list" {
    description = "return server instance ID after server module create server"
    type    = list(string)
}
variable "lb-name" {
    description = "Set Load Balancer name"
    type    = string
}
variable "lb-subnet" {
    description = "return lb subnet no after vpc module create lb subnet"
    type    = list(string)
}
