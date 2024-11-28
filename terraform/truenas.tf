resource "proxmox_virtual_environment_vm" "truenas" {

    # General information
    node_name = "proxmox"
    name = "TrueNAS"
    vm_id = 102
    tags = ["tf"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }

    # Startup information
    startup {
      order = 2
      up_delay = -1
      down_delay = -1
    }

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
    disk {
      datastore_id = ""
      interface = "scsi1"
      path_in_datastore = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E4D"
      backup = false
      size = 931
    }
    disk {
      datastore_id = ""
      interface = "scsi2"
      path_in_datastore = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E24"
      backup = false
      size = 931
    }
    disk {
      datastore_id = ""
      interface = "scsi3"
      path_in_datastore = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E3D"
      backup = false
      size = 931
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
            address = "10.10.1.2/24"
            gateway = "10.10.1.1"
        }
      }
      user_account {
        keys = [trimspace(data.local_file.public_ssh_key.content)]
        username = " "
      }
    }
}