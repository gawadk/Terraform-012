provider "aws" {
    region = "us-east-1"
}

variable "ingressrules" {
    type = list(number)
    default = [80,443,8443,9443]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080,8888]
}

resource "aws_instance" "MyEc2" {
    ami = "ami-09d3b3274b6c5d4aa"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.MyWebtraffic-SG.name]
}

resource "aws_security_group" "MyWebtraffic-SG" {
    name = "MyWebTraffic - SG - Allow HTTPS"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port 
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}