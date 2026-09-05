/* 
Specify any declared variables from the file of, variables.pkr.hcl, to override default values.
Example of default value of var cpu_name is 2 cores. We override that with 4 cores below.
*/

os_username = "administrator"
os_password = "temppassword"

vcenter_folder     = "Templates"
vcenter_server     = "vcsa-2.company.ycdisp.com"
vcenter_datacenter = "HomeLab Datacenter 2"
vcenter_cluster    = "AMD R7 Cluster"
vcenter_host       = "esxigmk1.company.ycdisp.com"
vcenter_datastore  = "vsanDatastore"

vm_name    = "TMP-Win2025Core_Packer"
vm_network = "DPG-Lab-LAN1"

vm_guest_os_type = "windows2019srvNext_64Guest"
vm_version       = "20"

os_iso_path      = "[esxigmk1:datastore1] Repo/26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
vmtools_iso_path = "[esxigmk1:datastore1] Repo/VMware-tools-windows-13.1.0-25218885.iso"

cpu_num   = 4
ram       = 4096
disk_size = 61440