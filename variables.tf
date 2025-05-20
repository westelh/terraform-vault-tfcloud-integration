variable "auth_path" {
  type        = string
  description = "Mount path for new auth backend for terraform cloud"
}

variable "roles" {
  type = map(object({
    workspace    = string,
    project      = string,
    organization = string,
    policies     = list(string)
  }))
}

