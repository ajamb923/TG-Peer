/*  List of ALL Variable   */
#---------------------------#

variable "ami" {
  description = "Please type in your AMI"
}

variable "ami2" {
  description = "Please type in your AMI"
}

variable "key_name" {
  description = "Please type in your key name"
}

variable "key_name2" {
  description = "Please type in the key name for other region"
}

variable "instance_type" {
  description = "Please type in the instance class"
}

variable "availability_zone" {
  description = "Please type in the availability zone"
  default     = "us-east-1a"
}

variable "subnet_cidr" {
  description = "Please type in the subnet cidr range"
}

