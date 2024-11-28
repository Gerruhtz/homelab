resource "proxmox_virtual_environment_vm" "opnsense" {

    # General information
    node_name = "proxmox"
    name = "OPNsense"
    vm_id = 101
    tags = ["tf"]
    on_boot = true
    agent { enabled = true }
    operating_system { type = "l26" }
    machine = "q35"

    # Startup information
    startup {
        order = 1
        up_delay = -1
        down_delay = -1
    }

    # Hardware information
    cpu {
        cores = 4
        type = "x86-64-v2-AES"
    }
    memory { dedicated = 4096 }
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
    }
    network_device {
        bridge = "vmbr_wan"
    }
}