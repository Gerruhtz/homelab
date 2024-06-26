resource "proxmox_vm_qemu" "DIMM-DEV02" {
    
    # General information
    name = "DIMM-DEV02"
    target_node = "DIMM-HV01"
    vmid = 2022
    ciuser = var.CIUSER
    tags = "tf,ansi,ctrl,dev"
    vm_state = "stopped"
    onboot = false

    # Cloning information
    clone = "TEMP-UBNT-2404-VID20"
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
                    size = 64
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
        bridge = "vmbr1"
        tag = 20
    }
    ipconfig0 = "ip=10.10.20.22/24,gw=10.10.20.1"
    sshkeys = var.PUBLIC_SSH_KEY
}
