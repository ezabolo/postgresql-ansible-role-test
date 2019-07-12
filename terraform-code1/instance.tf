resource "aws_key_pair" "mykey" { 
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}" 
}

resource "aws_instance" "postgres-prod-node1" { 
  ami = "ami-006219aba10688d0b"
  instance_type = "t2.medium"
  key_name = "${aws_key_pair.mykey.key_name}"
  
#Specifying the subnet id for prod server 
  subnet_id = "${aws_subnet.prod-public-1.id}"
  
 # vpc_security_group_ids = ["${aws_security_group.prod-postgres-secgroup.id}"]
    
  provisioner "file" { 
    source = "update-server.sh"
    destination = "/tmp/update-server.sh"
  }

  provisioner "remote-exec" {
   inline = [ 
     "chmod +x /tmp/update-server.sh",
     "sudo /tmp/update-server.sh"
   ]
  }
  connection { 
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

}

#Dev postgresql server

resource "aws_instance" "postgres-dev-node1" {
  ami = "ami-006219aba10688d0b"
  instance_type = "t2.medium"
  key_name = "${aws_key_pair.mykey.key_name}"

#Specifying the subnet id for prod server
  subnet_id = "${aws_subnet.dev-public-1.id}"

  vpc_security_group_ids = ["${aws_security_group.dev-postgres-secgroup.id}"]

  provisioner "file" {
    source = "update-server.sh"
    destination = "/tmp/update-server.sh"
  }

  provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/update-server.sh",
     "sudo /tmp/update-server.sh"
   ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

 tags { Name = "postgres-dev-node1"
    }

}

