variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS regions"
}

variable "default_tags" {
  type = map(string)
  default = {
    Terraform = true
    Project   = "factorio-tf"
  }
}


