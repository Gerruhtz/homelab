resource "proxmox_vm_qemu" "DIMM-IAC" {
    
    # General information
    name = "DIMM-IAC"
    target_node = "DIMM-HV01"
    vmid = 109
    agent = 1
    ciuser = "tadmin"

    # Cloning information
    #clone = "TEMP-UBNT-2404-VID20"
    #full_clone = true
    #os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 4
    memory = 8192
    scsihw = "virtio-scsi-single"
    onboot = true

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
                    replicate = true
                }
            }
        }
    }
    
    # Networking information
    network {
        model = "virtio"
        bridge = "vmbr0"
        #tag = 20
        firewall = true
    }
    ipconfig0 = "ip=10.10.1.9/24,gw=10.10.1.1"
    sshkeys = var.PUBLIC_SSH_KEY
    boot = "order=scsi0"
}