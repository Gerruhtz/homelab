resource "proxmox_vm_qemu" "DIMM-HA" {

    # General information
    name = "DIMM-HA"
    target_node = "DIMM-HV01"
    vmid = 1006
    ciuser = var.CIUSER
    agent = 1
    onboot = true
    tags = "tf"

    # Cloning information
    #clone = "TEMP-UBNT-2404-VID10"
    #full_clone = true
    #os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 1
    memory = 2048
    scsihw = "virtio-scsi-pci"
    bios = "ovmf"

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
                    cache = "writethrough"
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
        tag = 10
    }
    ipconfig0 = "ip=10.10.10.6/24,gw=10.10.10.1"
    sshkeys = var.PUBLIC_SSH_KEY
}