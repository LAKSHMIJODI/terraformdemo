
resource "aws_instance" "redhat" {
  ami           = "ami-05220ffa0e7fce3d1"
  instance_type = "t2.micro"
  key_name      = "jenkins"
  vpc_security_group_ids = ["${aws_security_group.allow_tls1.id}"]
  subnet_id = "${aws_subnet.db.id}"
  associate_public_ip_address = true

  tags = {
    Name = "redhat"
  }
 

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("./jenkins.pem")}"
  }
  
  provisioner "remote-exec" {

    inline = ["sudo yum update -y", "sudo yum install tree -y"]


  }
}
