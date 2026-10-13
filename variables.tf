variable "project_network" {
  description = "Name of the existing CSC cPouta project network."
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "Public IPv4 address allowed to access SSH, in CIDR notation."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && endswith(var.ssh_allowed_cidr, "/32")
    error_message = "Enter a valid IPv4 address in CIDR notation ending with /32, for example 203.0.113.10/32."
  }
}

variable "student_name" {
  description = "Name of the student displayed on the web server."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used when naming infrastructure resources."
  type        = string
  default     = "week7"
}

variable "image_name" {
  description = "Operating system image used for the virtual machine."
  type        = string
  default     = "Ubuntu-24.04"
}

variable "flavor_name" {
  description = "OpenStack flavor defining the virtual machine resources."
  type        = string
  default     = "standard.tiny"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key uploaded to cPouta."
  type        = string
  default     = "~/.ssh/week7_ed25519.pub"
}

variable "page_message" {
  description = "Week 7 implementation, weeee."
  type        = string
  default     = "This web server was automatically deployed using OpenTofu on CSC cPouta."
}