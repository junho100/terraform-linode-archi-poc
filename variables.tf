variable "token" {
  description = "The Linode API token"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "name of project"
  type        = string
  default     = "default"

  validation {
    condition     = length(var.project_name) < 11
    error_message = "length of project name should be less than 10 words."
  }
}

variable "instance_password" {
  description = "password for the instance"
  type        = string
}
