variable "city" {
  description = "name of the city that I reside"
  type = string
}

variable "zipcode" {
  description = "Zipcode of the city"
  type = number
}

variable "check" {
  description = "Check something"
  type = bool
  default = true
}

