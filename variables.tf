variable "instance_count" {
  type        = number
  description = "How many EC2 instances to create"
  default     = 2
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}


variable "name" {
   type = string
   description = "name of app"
}

