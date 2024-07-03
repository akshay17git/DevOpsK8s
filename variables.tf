variable "aws_region" {
    description = "region of the resource"
    type = string
    default = "us-east-1"
  
}

variable "subnet" {
    description = "this will be the default subnet in the vpc"
    type = string
    default = "subnet-0261f0e409b4cb858"
}

variable "key_name" {
    description = "this will be the keypair used"
    type = string
    default = "devopskey"
}
