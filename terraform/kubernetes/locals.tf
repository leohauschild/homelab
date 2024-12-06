locals {
  target_node = "thor"
  agent       = 1
  #clone       = "talos-template-1.8.3"
  cidr   = "192.168.1.100/24"
  scsihw = "virtio-scsi-pci"
  boot   = "order=scsi0;ide0;ide2;net0"

  bridge = {
    interface = "vmbr0"
    model     = "virtio"
  }

  disks = {
    main = {
      backup  = true
      format  = "raw"
      type    = "disk"
      storage = "local-lvm"
      slot    = "scsi0"
      discard = true
    }
    cloudinit = {
      backup  = true
      format  = "raw"
      type    = "cloudinit"
      storage = "local-lvm"
      slot    = "ide0"
    }
    iso = {
      type    = "cdrom"
      storage = "local"
      slot    = "ide2"
      iso     = "local:iso/nocloud-amd64.iso"
    }
  }

  serial = {
    id   = 0
    type = "socket"
  }

  masters = {
    count               = 1
    name_prefix         = "master"
    vmid_prefix         = 200
    cores               = 2
    disk_size           = "50G"
    memory              = 2048
    sockets             = 1
    network_last_octect = 110
    tags                = "master,control-plane,kubernetes"
  }
  workers = {
    count               = 1
    name_prefix         = "worker"
    vmid_prefix         = 300
    cores               = 2
    disk_size           = "50G"
    memory              = 8192
    sockets             = 1
    network_last_octect = 120
    tags                = "worker,kubernetes"
  }
}


