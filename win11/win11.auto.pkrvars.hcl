# Packer Variables for Windows 11 Build
# Adding SKIP_BUILD to skip CICD build process. Remove SKIP_BUILD to run build process.

os_username = "administrator"
os_password = "temppassword"

vcenter_folder     = "Templates"
vcenter_server     = "vcsa-1.local.lan"
vcenter_datacenter = "HomeLab Datacenter"
vcenter_cluster    = "Intel NUC10 Cluster"
vcenter_host       = "esxinuc2.local.lan"
vcenter_datastore  = "esxinuc2:datastore1"

vm_name    = "TMP-Win11_Packer"
vm_network = "DPG-Lab-LAN1"

vm_guest_os_type = "windows9_64Guest" # Refer to https://code.vmware.com/apis/704/vcenter/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html for guest OS types.
vm_version       = "20"               # Refer to https://kb.vmware.com/s/article/1003746 for specific VM versions.

os_iso_path      = "[esxinuc2:datastore1] Repo/Win11_25H2_English_x64_v2.iso"
vmtools_iso_path = "[esxinuc2:datastore1] Repo/VMware-tools-windows-13.1.0-25218885.iso"
# floppy_img_path  = "[esxinuc1:datastore1] Repo/pvscsi-Windows8.flp"

cpu_num   = 4
ram       = 4096
disk_size = 40960