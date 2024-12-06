resource "proxmox_vm_qemu" "master" {
  count = local.masters.count

  target_node = local.target_node
  vmid        = local.masters.vmid_prefix + count.index
  name        = format("%s-%s", local.masters.name_prefix, count.index)
  boot        = local.boot
  agent       = local.agent

  cores   = local.masters.cores
  sockets = local.masters.sockets
  memory  = local.masters.memory

  ipconfig0 = format("ip=%s/24,gw=%s", cidrhost(local.cidr, local.masters.network_last_octect + count.index), cidrhost(local.cidr, 1))

  network {
    id     = 0
    bridge = local.bridge.interface
    model  = local.bridge.model
  }

  scsihw = local.scsihw

  serial {
    id   = local.serial.id
    type = local.serial.type
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size    = local.masters.disk_size
          storage = local.disks.main.storage
          backup  = local.disks.main.backup
          format  = local.disks.main.format
          discard = local.disks.main.discard
        }
      }
    }
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/nocloud-amd64.iso"
        }
      }
      ide0 {
        cloudinit {
          storage = local.disks.cloudinit.storage
        }
      }
    }
  }

  tags = local.masters.tags
}