resource "proxmox_virtual_environment_vm" "automation" {

    # General information
    node_name = "proxmox"
    name = "Automation"
    vm_id = 1009
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Hardware information
    cpu {
        cores = 6
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 16384 }
    scsi_hardware = "virtio-scsi-single"

    # Disk information
    disk {
        interface = "scsi0"
        backup = true
        datastore_id = "local-btrfs"
        discard = "on"
        file_format = "raw"
        size = 32
    }

    # Networking information
    network_device {
      bridge = "vmbr_lan"
      vlan_id = 10
    }

    # Cloud-init information
    initialization {
      datastore_id = "local-btrfs"
      interface = "ide0"
      dns { servers = ["10.10.10.1"] }
      ip_config {
        ipv4 {
            address = "10.10.10.9/24"
            gateway = "10.10.10.1"
        }
      }
      user_account {
        username = "tadmin"
        password = var.SSH_PASS
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }
}