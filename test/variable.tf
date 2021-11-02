variable "aws_region" {}
variable "aws_zones" {
 type        = list
 description = "List of availability zones to use"
 default     = ["ap-south-1a", "ap-south-1b"]
}

variable "AMIS" {
    type = map
    default = {
        ap-south-1 = "ami-0fd48e51ec5606ac1"
    }
}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}


variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

