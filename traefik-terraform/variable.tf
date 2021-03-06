variable "name" {
  description = "name prefix to assign to traefik"
  type = string
  default = "terraform-traefik"
}

variable "namespace" {
  description = "namespace to deploy traefik"
  type = string
  default = "dev"
}

variable "traefik-image" {
  description = "traefik image to use"
  type = object({
    image = string
    tag = string
  })
  default = {
    image = "traefik"
    tag   = "2.4.0"
  }
}

variable "loglevel" {
  description = "traefik log level"
  default     = "WARN"
}
