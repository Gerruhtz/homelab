resource "proxmox_vm_qemu" "DIMM-MEDIA" {
    
    # General information
    name = "DIMM-MEDIA"
    target_node = "DIMM-HV01"
    vmid = 1011
    ciuser = var.CIUSER
    tags = "tf,ansi"
    onboot = true
    agent = 1

    # Cloning information
    clone = "TEMP-UBNT-2404-VID10"
    full_clone = true
    os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 4
    memory = 8192
    scsihw = "virtio-scsi-single"

    # Disk information
    disks {
        scsi {
            scsi0 {
                disk {
                    storage = "local-btrfs"
                    size = 32
                    emulatessd = true
                    discard = true
                    backup = true
                    iothread = true
                }
            }
        }
        ide {
            ide0 {
                cloudinit {
                    storage = "local-btrfs"
                }
            }
        }
    }
    
    # Networking information
    network {
        model = "virtio"
        bridge = "vmbr_lan"
        tag = 10
    }
    ipconfig0 = "ip=10.10.10.11/24,gw=10.10.10.1"
    sshkeys = var.PUBLIC_SSH_KEY
}