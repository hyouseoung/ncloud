variable "acg-name" {
    description = "Set ACG Name"
    type    = string
}
variable "vpc-id" {
    description = "Return vpc id after vpc module create vpc"
    type    = string
}
variable "source-ip" {
    description = "Set source ip for ssh connect"
    type    = string
}