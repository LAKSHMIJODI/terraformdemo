resource "aws_vpc" "ntire" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "web" {
  vpc_id     = "${aws_vpc.ntire.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main1"
  }
}
resource "aws_subnet" "db" {
  vpc_id     = "${aws_vpc.ntire.id}"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Main2"
  }
}
resource "aws_subnet" "mngt" {
  vpc_id     = "${aws_vpc.ntire.id}"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Mai3n"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ntire.id}"

  tags = {

    Name = "main"

  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.ntire.id}"
  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "main"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.web.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.db.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.mngt.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_security_group" "allow_tls1" {
  name        = "allow_tls1"
  vpc_id      = "${aws_vpc.ntire.id}"

  ingress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
 
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow"
  }
}