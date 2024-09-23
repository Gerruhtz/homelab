resource "proxmox_virtual_environment_vm" "DIMM-ESXI" {

    # General information
    node_name = "DIMM-HV01"
    name = "DIMM-ESXI"
    vm_id = 2020
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Hardware information
    cpu {
        cores = 8
        type = "host"
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
        size = 128
    }

    # ISO information
    cdrom {
        enabled = true
        file_id = "local-btrfs:iso/VMware-VMvisor-Installer-7.0.0-15843807.x86_64.iso"
        interface = "ide0"
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
      dns { servers = ["10.10.20.1"] }
      ip_config {
        ipv4 {
            address = "10.10.20.20/24"
            gateway = "10.10.20.1"
        }
      }
      user_account {
        username = "tadmin"
        password = var.SSH_PASS
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }
}