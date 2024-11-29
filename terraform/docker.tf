resource "proxmox_virtual_environment_vm" "docker" {

    # General information
    node_name = "proxmox"
    name = "Docker"
    vm_id = 1010
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Startup information
    startup {
      order = 3
      up_delay = 90
      down_delay = 120
    }

    # Hardware information
    cpu {
        cores = 4
        type = "host"
        numa = true
    }
    memory {
        dedicated = 8192
        floating = 4096
    }
    scsi_hardware = "virtio-scsi-single"

    # Disk information
    disk {
        interface = "scsi0"
        backup = true
        datastore_id = "local-btrfs"
        discard = "on"
        ssd = true
        iothread = true
        file_format = "raw"
        size = 64
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
            address = "10.10.10.10/24"
            gateway = "10.10.10.1"
        }
      }
      user_account {
        username = "tadmin"
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }
}