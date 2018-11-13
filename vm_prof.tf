resource "azurerm_virtual_machine" "unix" {
  name                  = "Terraform-unixVM"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "Standard_DS1_v2"


  #delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "test"
  }

  storage_os_disk {
    name          = "osdisk-1"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.cont.name}/osdisk-1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "ubuntuunix"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    group = "Terraform"
  }
}

resource "azurerm_virtual_machine" "windows" {
  name                  = "Terraform-windowsVM"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.public_nic1.id}"]
  vm_size               = "Standard_DS1_v2"

#This will delete the OS disk and data disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  #delete_data_disks_on_termination = true

storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }


  storage_os_disk {
    name          = "osdisk-2"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.cont.name}/osdisk-2.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  # Optional data disks
  storage_data_disk {
    name          = "datadisk-2"
    vhd_uri       = "${azurerm_storage_account.storage.primary_blob_endpoint}${azurerm_storage_container.cont.name}/datadisk-2.vhd"
    disk_size_gb  = "100"
    create_option = "Empty"
    lun           = 0
  }

  os_profile {
    computer_name  = "Micwindows"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    group = "Terraform"
  }
}