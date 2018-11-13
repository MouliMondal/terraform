resource "azurerm_public_ip" "pip" {
  name 				= "Terraform-PIP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "dynamic"

  tags {
	group = "Terraform"
  }
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "Terraform-unix"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.nsg_unix.id}"

  ip_configuration {
    name 			= "Terraform-unixPrivate"
    subnet_id 			= "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.pip.id}"
  }
  tags {
	group = "Terraform"
  }
}

resource "azurerm_public_ip" "pip1" {
  name 				= "Terraform-PIP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.terraform_rg.name}"
  public_ip_address_allocation 	= "dynamic"

  tags {
	group = "Terraform"
  }
}

resource "azurerm_network_interface" "public_nic1" {
  name 		      = "Terraform-win"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.nsg_windows.id}"

  ip_configuration {
    name 			= "Terraform-winPrivate"
    subnet_id 			= "${azurerm_subnet.subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.pip1.id}"
  }
  tags {
	group = "Terraform"
  }
}