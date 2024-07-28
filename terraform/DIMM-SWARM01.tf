resource "proxmox_vm_qemu" "DIMM-SWARM01" {
    
    # General information
    name = "DIMM-SWARM01"
    target_node = "DIMM-HV01"
    vmid = 1021
    ciuser = var.CIUSER
    tags = "tf,ansi,ctrl"
    onboot = true

    # Cloning information
    clone = "TEMP-UBNT-2404-VID10"
    full_clone = true
    os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 1
    memory = 2048
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
        bridge = "vmbr_lan"
        tag = 10
    }
    ipconfig0 = "ip=10.10.10.21/24,gw=10.10.10.1"
    sshkeys = var.PUBLIC_SSH_KEY
}
