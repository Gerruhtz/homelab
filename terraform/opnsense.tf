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
        up_delay = 30
        down_delay = 60
    }

    # Hardware information
    cpu {
        cores = 2
        type = "host"
        flags = ["+aes"]
        numa = true
    }
    memory {
        dedicated = 2048
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
    }
    network_device {
        bridge = "vmbr_wan"
    }
}