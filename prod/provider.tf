terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}

variable "PM_API_URL" {
  type = string
}

variable "PM_API_TOKEN_ID" {
  type = string
  sensitive = true
}

variable "PUBLIC_SSH_KEY" {
  type = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url = var.PM_API_URL
  pm_api_token_id = var.PM_API_TOKEN_ID
  pm_tls_insecure = true
}
