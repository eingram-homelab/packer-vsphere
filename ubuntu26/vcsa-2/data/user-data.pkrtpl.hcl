#cloud-config
autoinstall:
  version: 1
  apt:
    geoip: true
    preserve_sources_list: true
    primary:
      - arches: [amd64, i386]
        uri: http://us.archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports    
  early-commands:
    # Ensures that Packer does not connect too soon.
    - sudo systemctl stop ssh
  locale: en_US
  keyboard:
    layout: us
  storage:
    config:
      - type: disk
        id: disk-sda
        path: /dev/sda
        ptable: gpt
        wipe: superblock-recursive
        preserve: false
        grub_device: false
      - type: partition
        id: partition-0
        device: disk-sda
        number: 1
        size: 1127219200
        flag: boot
        wipe: superblock
        preserve: false
        grub_device: true
      - type: partition
        id: partition-1
        device: disk-sda
        number: 2
        size: 2147483648
        wipe: superblock
        preserve: false
        grub_device: false
      - type: partition
        id: partition-2
        device: disk-sda
        number: 3
        size: -1
        wipe: superblock
        preserve: false
        grub_device: false
      - type: format
        id: format-0
        volume: partition-0
        fstype: fat32
        preserve: false
      - type: format
        id: format-1
        volume: partition-1
        fstype: ext4
        preserve: false
      - type: lvm_volgroup
        id: lvm_volgroup-0
        name: ubuntu-vg
        devices: [partition-2]
        preserve: false
      - type: lvm_partition
        id: lvm_partition-0
        name: ubuntu-lv
        volgroup: lvm_volgroup-0
        size: -1
        wipe: superblock
        preserve: false
      - type: format
        id: format-2
        volume: lvm_partition-0
        fstype: ext4
        preserve: false
      - type: mount
        id: mount-2
        device: format-2
        path: /
      - type: mount
        id: mount-1
        device: format-1
        path: /boot
      - type: mount
        id: mount-0
        device: format-0
        path: /boot/efi
  identity:
    hostname: ubuntu-server
    username: tempuser
    password: $6$PtgsSOYcedPXOAbi$nbuIwp5OLrZ1opLUOKgfP8D0thOYCaCRHN6v6L38xWBRshvKWb7wor06rn6qwpu7yrK8VuQysUi8JMfT4DQLL.
  network:
    network:
      version: 2
      ethernets:
        ens33:
          dhcp4: true
          dhcp-identifier: mac
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - openssh-server
    - open-vm-tools
    - net-tools
    - cloud-init
  user-data:
    disable_root: false
    package_update: true
    package_upgrade: true
    package_reboot_if_required: true
  timezone: UTC
  late-commands:
    - curtin in-target --target=/target -- sh -c 'printf "%s\n" "tempuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-tempuser'
    - curtin in-target --target=/target -- chmod 0440 /etc/sudoers.d/90-tempuser
    - curtin in-target --target=/target -- visudo -cf /etc/sudoers.d/90-tempuser