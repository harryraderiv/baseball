variable "web_ami_type" {
  description = "ami to be used"
  type        = string
  default     = "ami-0c803b171269e2d72"
}

variable "web_instance_type" {
  description = "instance type"
  type = string
  default = "t2.micro"
}