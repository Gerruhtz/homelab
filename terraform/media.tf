resource "proxmox_virtual_environment_vm" "media" {

    # General information
    node_name = "proxmox"
    name = "Media"
    vm_id = 1011
    tags = ["tf", "ansi"]
    on_boot = true
    agent { enabled = true }
    operating_system {
      type = "l26"
    }
    machine = "q35"

    # Hardware information
    cpu {
        cores = 4
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 8192 }
    scsi_hardware = "virtio-scsi-single"
    hostpci {
      device = "hostpci0"
      mapping = "RTX-A2000"
      pcie = true
      xvga = true
    }

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
      vlan_id = 10
    }

    # Cloud-init information
    initialization {
      datastore_id = "local-btrfs"
      interface = "ide0"
      dns {
        servers = ["10.10.10.1"]
      }
      ip_config {
        ipv4 {
            address = "10.10.10.11/24"
            gateway = "10.10.10.1"
        }
      }
      user_account {
        username = "tadmin"
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }
}
