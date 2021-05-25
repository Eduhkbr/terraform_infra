resource "null_resource" "install-mysql" {
    
  triggers = {
    order = azurerm_linux_virtual_machine.as02-vm.id
  }
  
  connection{
        type = "ssh"
        user = var.user-vm
        password = var.password-user-vm
        host = azurerm_public_ip.as02-ip.ip_address
  }

  provisioner "file" {
    source      = "mysql"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    
    script = "./script.sh"
  }
}
