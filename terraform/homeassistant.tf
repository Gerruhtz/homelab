resource "proxmox_virtual_environment_vm" "homeassistant" {

    # General information
    node_name = "proxmox"
    name = "HomeAssistant"
    vm_id = 1006
    tags = ["tf"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }
    bios = "ovmf"

    # Hardware information
    cpu {
        cores = 1
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 2048 }
    scsi_hardware = "virtio-scsi-pci"

    # Disk information
    disk {
        interface = "scsi0"
        backup = true
        cache = "writethrough"
        datastore_id = "local-btrfs"
        discard = "on"
        ssd = true
        file_format = "raw"
        size = 32
    }
    efi_disk {
      datastore_id = "local-btrfs"
      file_format = "raw"
      pre_enrolled_keys = false
      type = "4m"
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
            address = "10.10.10.6/24"
            gateway = "10.10.10.1"
        }
      }
      user_account {
        username = "tadmin"
        keys = [trimspace(data.local_file.public_ssh_key.content)]
      }
    }
}