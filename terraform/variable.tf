variable "project_name" {
  default     = "cognata"
  type        = string
  description = "Name of the project"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "Environment name"

}

variable "location" {
  default     = "westeurope"
  type        = string
  description = "location in which resources will be created"
}

variable "name" {
  default     = "vm-cognata"
  type        = string
  description = "vm name"
}

variable "default_tags" {
  type = map(string)
  default = {
    environment = "dev"
    project     = "cognata"
    creator     = "jkercov"
  }
}

variable "admin_password" {
  default = "#{goodsecret}#"
}
