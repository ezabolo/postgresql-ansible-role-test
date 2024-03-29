resource "aws_security_group" "prod-postgres-secgroup" {
  vpc_id = "${aws_vpc.vpc-prod.id}"
  name = "prod-postgres-secgroup"
  description = "security group that allows ping, ssh, posgres and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 5432
      to_port = 5432 
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 8
      to_port = 0
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

tags {
    Name = "prod-secgroup"
  }
}

#Security Group for dev vpc

resource "aws_security_group" "prod-postgres-secgroup" {
  vpc_id = "${aws_vpc.vpc-dev.id}"
  name = "dev-postgres-secgroup"
  description = "security group that allows ping, ssh, posgres and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 8
      to_port = 0
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

tags {
    Name = "dev-secgroup"
  }
}

