resource "proxmox_virtual_environment_vm" "automation" {

    # General information
    node_name = "proxmox"
    name = "Automation"
    vm_id = 1009
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Startup information
    startup {
      order = 6
      up_delay = 180
      down_delay = 60
    }

    # Hardware information
    cpu {
        cores = 2
        type = "host"
        numa = true
    }
    memory {
        dedicated = 4096
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