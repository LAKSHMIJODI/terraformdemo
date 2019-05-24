
resource "aws_instance" "ubuntu" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "jenkins"
  vpc_security_group_ids = ["${aws_security_group.allow_tls1.id}"]
  subnet_id = "${aws_subnet.mngt.id}"
  associate_public_ip_address = true

  tags = {
    Name = "ubuntu"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("./jenkins.pem")}"
  }
  
  provisioner "remote-exec" {

    inline = ["sudo apt update", "sudo apt install tree -y"]


  }
}
