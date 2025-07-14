variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_ami" {
  default = "ami-0f918f7e67a3323f0"
  type    = string
}

variable "ec2_root_volume_size" {
  default = 25
  type    = number
}

