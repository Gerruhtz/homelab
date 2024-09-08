resource "proxmox_vm_qemu" "DIMM-MINECRAFT" {
    
    # General information
    name = "DIMM-MINECRAFT"
    target_node = "DIMM-HV01"
    vmid = 2010
    ciuser = var.CIUSER
    tags = "tf,ansi"
    onboot = true
    agent = 1
    vm_state = "stopped"

    # Cloning information
    clone = "TEMP-UBNT-2404-VID20"
    full_clone = true
    os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 8
    memory = 32768
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
        tag = 20
    }
    ipconfig0 = "ip=10.10.20.10/24,gw=10.10.20.1"
    sshkeys = var.PUBLIC_SSH_KEY
}