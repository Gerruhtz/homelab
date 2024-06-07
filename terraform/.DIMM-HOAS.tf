resource "proxmox_vm_qemu" "DIMM-HOAS" {
    
    # General information
    name = "DIMM-HOAS"
    target_node = "DIMM-HV01"
    vmid = 105
    agent = 1
    ciuser = var.CIUSER

    # Cloning information
    # clone = "TEMP-UBNT-2404-VID20"
    # full_clone = true
    # os_type = "cloud-init"

    # Hardware information
    cpu = "host"
    sockets = 1
    cores = 1
    memory = 2048
    scsihw = "virtio-scsi-pci"
    onboot = true
    bios = "ovmf"

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
    ipconfig0 = "ip=10.10.1.5/24,gw=10.10.1.1"
    sshkeys = var.PUBLIC_SSH_KEY
    boot = "order=scsi0"
}