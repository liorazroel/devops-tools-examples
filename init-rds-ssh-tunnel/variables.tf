variable "region" { 
  default = "us-east-1"
  type = string
  description = "The region to deploy to"
}

variable "rds_endpoint" {
  default = ""
  type = string
  description = "The RDS endpoint to connect to"
}

variable "rds_admin_username" {
  default = ""
  type = string
  description = "The RDS admin username"
}
  
variable "rds_admin_password" {
  default = ""
  type = string
  description = "The RDS admin password"
}

variable "environment_name" {
  default = ""
  type = string
  description = "The environment name"
}