resource "proxmox_virtual_environment_vm" "DIMM-DOCKER" {

    # General information
    node_name = "DIMM-HV01"
    name = "DIMM-DOCKER"
    vm_id = 1010
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Hardware information
    cpu {
        cores = 2
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 4096 }
    scsi_hardware = "virtio-scsi-single"

    # Disk information
    disk {
        interface = "scsi0"
        backup = true
        datastore_id = "local-btrfs"
        discard = true
        file_format = "raw"
        size = 64
    }

    # Networking information
    network_device {
      bridge = "vmbr-lan"
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

    # Cloning information
    clone {
        vm_id = 9010
        datastore_id = "local-btrfs"
    }
}