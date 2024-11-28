resource "proxmox_virtual_environment_vm" "fontys-automation" {

    # General information
    node_name = "proxmox"
    name = "Fontys-Automation"
    vm_id = 2010
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system {
      type = "l26"
    }
    machine = "q35"

    # Startup information
    startup {
      order = 5
      up_delay = -1
      down_delay = -1
    }

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
        ssd = true
        file_format = "raw"
        size = 128
    }

    # Networking information
    network_device {
      bridge = "vmbr_lan"
      vlan_id = 20
    }

    # Cloud-init information
    initialization {
      datastore_id = "local-btrfs"
      interface = "ide0"
      dns {
        servers = ["10.10.20.1"]
      }
      ip_config {
        ipv4 {
            address = "10.10.20.10/24"
            gateway = "10.10.20.1"
        }
      }
      user_account {
        username = "tadmin"
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }

    # Cloning information
    clone {
       vm_id = 9020
       datastore_id = "local-btrfs"
    }
}
