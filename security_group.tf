data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_default_security_group" "default" {
  # vpc_id = aws_default_vpc.default.id
  vpc_id = data.aws_vpc.default.id
  
  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "default"
    Project  = var.your_project_name
  }
}

output "sg_default_id" {
  value = aws_default_security_group.default.id
}

resource "aws_security_group" "salt_manager" {
  name        = "salt_manager"
  description = "salt manager"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    description = "icmp"
    cidr_blocks = ["172.31.0.0/16"]
  }


  ingress {
    from_port = 4505
    to_port   = 4505
    protocol  = "tcp"
    description = "salt"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    from_port = 4506
    to_port   = 4506
    protocol  = "tcp"
    description = "salt"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }

  tags = {
    Name     = "salt_manager"
    Project  = var.your_project_name
  }
}

output "sg_salt_manager_id" {
  value = aws_security_group.salt_manager.id
}

resource "aws_security_group" "myip" {
  name        = "myip"
  description = "SG for my Ip"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  tags = {
    Name     = "myip"
    Project  = var.your_project_name
  }
}

output "sg_myip_id" {
  value = aws_security_group.myip.id
}