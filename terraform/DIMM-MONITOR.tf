resource "proxmox_vm_qemu" "DIMM-MONITOR" {
    
    # General information
    name = "DIMM-MONITOR"
    target_node = "DIMM-HV01"
    vmid = 108
    ciuser = var.CIUSER
    tags = "tf,ansi"
    onboot = true
    agent = 1

    # Cloning information
    clone = "TEMP-UBNT-2404-VID1"
    full_clone = true
    os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 2
    memory = 4096
    scsihw = "virtio-scsi-single"

    # Disk information
    disks {
        scsi {
            scsi0 {
                disk {
                    storage = "local-btrfs"
                    size = 128
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
        #tag = 1
    }
    ipconfig0 = "ip=10.10.1.8/24,gw=10.10.1.1"
    sshkeys = var.PUBLIC_SSH_KEY
}
