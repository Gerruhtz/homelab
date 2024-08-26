resource "proxmox_vm_qemu" "DIMM-NAS02" {
    
    # General information
    name = "DIMM-NAS02"
    target_node = "DIMM-HV01"
    vmid = 107
    agent = 1
    onboot = true
    tags = "tf,ansi"

    # Cloning information
    #clone = "TEMP-UBNT-2404-VID10"
    full_clone = false
    os_type = "l26"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 4
    memory = 16384
    scsihw = "virtio-scsi-single"
    boot = "order=scsi0;net0"

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
                    replicate = true
                }
            }
            scsi1 {
                passthrough {
                    file = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E4D"
                    replicate = true
                    backup = false
                }
            }
            scsi2 {
                passthrough {
                    file = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E24"
                    replicate = true
                    backup = false
                }
            }
            scsi3 {
                passthrough {
                    file = "/dev/disk/by-id/ata-CT1000BX500SSD1_2340E87C7E3D"
                    replicate = true
                    backup = false
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
    ipconfig0 = "ip=10.10.1.7/24,gw=10.10.10.1"
    sshkeys = var.PUBLIC_SSH_KEY
    define_connection_info = true
}