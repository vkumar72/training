#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-bird
#

###### CHANGE No. 1

###### CHANGE No. 2

###### CHANGE No. 3

variable "aws_access_key" {
  type    = "string"
  default = "AKIAJCP4JQU5RVLYSJEA"
}

variable "aws_secret_key" {
  type    = "string"
  default = "1HmfoAFOOaRtKPzXK0he2mlg+FdoBqdWthH8A6nL"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

variable "count" {
  default = "1"
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ddd57685"
  vpc_security_group_ids = ["sg-29ef374e"]
  count                  = "${var.count}"

  tags {
    Identity    = "autodesk-bird"
    Environment = "Dev"
    Product     = "myproduct"
    Name        = "web ${count.index + 1}/${var.count}"
  }
}
