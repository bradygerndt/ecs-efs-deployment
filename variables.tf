variable "aws_regions" {
  type        = list(string)
  default     = ["us-east-1", "us-east-2"]
  description = "AWS regions"
}

variable "default_tags" {
  type = map(string)
  default = {
    Terraform = true
    Project   = "factorio-tf"
  }
}

