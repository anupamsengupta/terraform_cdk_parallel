variable "stack_name" {
  description = "Name of the stack"
  type        = string
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
}

variable "subnets_per_az_count" {
  description = "Number of subnets per availability zone"
  type        = number
  default     = 2
}

variable "subnets_per_az_names" {
  description = "Names for the subnets per availability zone"
  type        = list(string)
  default     = ["public", "private"]
}

variable "context" {
  description = "Context from the root label module"
  type        = any
}