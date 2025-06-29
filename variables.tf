variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
  default     = "qs-example"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_cidrs" {
  description = "CIDR block for the VPC"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
  default     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/example-repo"
}

variable "environment_vars" {
  description = "Environment variables for the ECS task"
  type        = map(string)
  default     = {}

}
variable "default_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Environment = "TEST"
    Project     = "CloudSample1"
    ManagedBy   = "Terraform"
    Ticket      = "ICRQ-1884"
  }
}
