# variables
variable "your_project_name" {
    type = string
    default = "k9swarm"
}

variable "aws_region" {
    type = string
    default = "eu-west-1"
}

variable "aws_config_profile" {
    type = string
    default = "perso"
}

variable "s3_bucket_setting_name" {
    type = string
    default = "k9-setting-centos"
}

# Ubuntu 20.04 LTS
variable "aws_ec2_ami" {
    type = string
    default = "ami-0bfa4fefe067b7946"
}

variable "aws_ec2_instance_type" {
    type = string
    default = "t3a.large"
}

variable "aws_ssh_key_name" {
    type = string
    default = "karlesnine"
}