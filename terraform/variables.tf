variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "db_password" {
  sensitive = true
}
