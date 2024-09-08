terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.63.0"
    }
  }
}

variable "PM_API_URL" {
  type = string
}

variable "PUBLIC_SSH_KEY" {
  type = string
  sensitive = true
}

variable "PM_API" {
  type = string
  sensitive = true
}

variable "SSH_PASS" {
  type = string
  sensitive = true
}

provider "proxmox" {
  endpoint = var.PM_API_URL
  api_token = var.PM_API
  insecure = true
}

data "local_file" "public_ssh_key" {
    filename = "/home/tadmin/.ssh/pubkey"
}