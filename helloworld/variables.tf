variable "project" { type = string }
variable "region" { type = string }
variable "environment" { type = string }
variable "env" { type = string }
variable "domain" { type = string }
variable "owner" { type = string }
variable "team" { type = string }

variable "hostname" {
  type    = string
  default = "hello"
}

variable "https_port" {
  type    = string
  default = "443"
}

variable "lambda_port" {
  type    = number
  default = 80
}
