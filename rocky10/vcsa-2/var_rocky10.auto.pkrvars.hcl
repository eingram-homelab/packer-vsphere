# Assign values to override their default values (default values are found in the vsphere_centos8.pkr.hcl file).
# All values are automatically used and persist through the entire Packer process.

vsphere_template_name = "TMP-Rocky10_Packer"
vm_folder             = "Templates"

cpu_num   = 4
mem_size  = 4096
disk_size = 61450

vcenter_server    = "vcsa-2.company.ycdisp.com"
vcenter_dc_name   = "HomeLab Datacenter 2"
vcenter_cluster   = "AMD R7 Cluster"
vsphere_host      = "esxigmk1.company.ycdisp.com"
vcenter_datastore = "esxigmk1:datastore1"
vm_network        = "DPG-Lab-LAN1"

os_iso_path         = "[esxigmk1:datastore1] Repo/Rocky-10.2-x86_64-dvd1.iso"
vm_version          = "20"
convert_to_template = true
os_version          = "Rocky Linux 10"
