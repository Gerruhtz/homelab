resource "proxmox_vm_qemu" "DIMM-FW" {
    
    # General information
    name = "DIMM-FW"
    target_node = "DIMM-HV01"
    vmid = 101
    onboot = true
    agent = 1
    tags = "tf"
    machine = "q35"
    skip_ipv6 = true

    # Cloning information
    # clone = "TEMP-UBNT-2404-VID10"
    full_clone = false
    # os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 4
    memory = 4096
    scsihw = "virtio-scsi-single"

    # Disk information
    disks {
        scsi {
            scsi0 {
                disk {
                    storage = "local-btrfs"
                    size = 64
                    emulatessd = false
                    discard = true
                    backup = true
                    iothread = true
                    replicate = true
                }
            }
        }
    }
    
    # Networking information
    network {
        model = "virtio"
        bridge = "vmbr_lan"
        firewall = true
    }

    network {
        model = "virtio"
        bridge = "vmbr_wan"
        firewall = true   
    }

    #ipconfig0 = "ip=10.10.10.10/24,gw=10.10.10.1"
    #sshkeys = var.PUBLIC_SSH_KEY
}
