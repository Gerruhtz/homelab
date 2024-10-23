resource "proxmox_virtual_environment_vm" "truenas" {

    # General information
    node_name = "proxmox"
    name = "truenas"
    vm_id = 107
    tags = ["tf"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Hardware information
    cpu {
        cores = 2
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
        ssd = true
        file_format = "raw"
        size = 64
    }

    # Networking information
    network_device {
      bridge = "vmbr_lan"
    }

    # Cloud-init information
    initialization {
      datastore_id = "local-btrfs"
      interface = "ide0"
      dns { servers = ["10.10.1.1"] }
      ip_config {
        ipv4 {
            address = "10.10.1.7/24"
            gateway = "10.10.1.1"
        }
      }
      user_account {
        keys = [trimspace(data.local_file.public_ssh_key.content)]
        username = " "
      }
    }
}