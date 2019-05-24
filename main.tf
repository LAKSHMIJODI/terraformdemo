provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region = "us-east-2"
  }

resource "aws_instance" "web" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.micro"
  key_name      = "jenkins"
  vpc_security_group_ids = ["${aws_security_group.allow_tls1.id}"]
  subnet_id = "${aws_subnet.web.id}"
  associate_public_ip_address = true

  tags = {
    Name = "HelloWorld"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("./jenkins.pem")}"
  }
  
  provisioner "remote-exec" {

    inline = ["sudo apt-get update", "sudo apt-get install python -y"]
  }
}
