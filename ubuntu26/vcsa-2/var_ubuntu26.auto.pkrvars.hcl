# Assign values to override their default values (default values are found in the vsphere_centos8.pkr.hcl file).
# All values are automatically used and persist through the entire Packer process.

vsphere_template_name = "TMP-Ubuntu26_Packer"
vm_folder             = "Templates"

cpu_num   = 4
mem_size  = 4096
disk_size = 61450

vcenter_server  = "vcsa-2.company.ycdisp.com"
vcenter_dc_name = "HomeLab Datacenter 2"
vcenter_cluster = "AMD R7 Cluster"
# vsphere_host      = "esxigmk1.company.ycdisp.com"
vcenter_datastore = "vsanDatastore"
vm_network        = "DPG-Lab-LAN2"

os_iso_path = "ISO/ubuntu-26.04.1-live-server-amd64/ubuntu-26.04.1-live-server-amd64.iso"
vm_version  = "20"
