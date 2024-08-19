resource "proxmox_vm_qemu" "DIMM-NIXOS" {
    
    # General information
    name = "DIMM-NIXOS"
    target_node = "DIMM-HV01"
    vmid = 2015
    ciuser = var.CIUSER
    tags = "tf,ansi"
    onboot = true

    # Cloning information
    # clone = "TEMP-UBNT-2404-VID20"
    # full_clone = true
    # os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 4
    memory = 16384
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
        # ide {
        #     ide0 {
        #         cloudinit {
        #             storage = "local-btrfs"
        #         }
        #     }
        # }
    }
    
    # Networking information
    network {
        model = "virtio"
        bridge = "vmbr_lan"
        tag = 20
    }
    ipconfig0 = "ip=10.10.20.15/24,gw=10.10.20.1"
    sshkeys = var.PUBLIC_SSH_KEY
}