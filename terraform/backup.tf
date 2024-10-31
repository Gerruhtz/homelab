resource "proxmox_virtual_environment_vm" "backup" {

    # General information
    node_name = "proxmox"
    name = "Backup"
    vm_id = 102
    tags = ["tf"]
    on_boot = true
    agent { enabled = true }

    # Hardware information
    cpu {
        cores = 4
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 8192 }
    scsi_hardware = "virtio-scsi-single"

    # Disk information
    disk {
        interface = "scsi0"
        backup = true
        datastore_id = "local-btrfs"
        discard = "on"
        file_format = "raw"
        size = 64
    }

    # Networking information
    network_device {
      bridge = "vmbr_lan"
      vlan_id = 1
    }

    # Cloud-init information
    initialization {
      datastore_id = "local-btrfs"
      interface = "ide0"
      dns { servers = ["10.10.10.1"] }
      ip_config {
        ipv4 {
            address = "10.10.1.2/24"
            gateway = "10.10.10.1"
        }
      }
      user_account {
        username = "tadmin"
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }

}