
provider "aws" {
  region = "us-west-1"
}

variable "enable_jenkins_instance" {
  description   = "If set to true, create Jenkins instance and attach persistant volume"
  type          = bool
  default       = false
}

resource "aws_ebs_volume" "jenkins" {
  availability_zone     = "us-west-2a"
  size                  = 8
  encrypted             = true

  tags = {
    content = "jenkins-data"
  }
}

resource "aws_instance" "jenkins" {
  count         = "${var.enable_jenkins_instance}" ? 1 : 0
  ami                   = "ami-21f78e11"
  instance_type         = "t1.micro"

  availability_zone     = "us-west-2a"

  tags = {
    Name = "jenkins"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count         = "${var.enable_jenkins_instance}" ? 1 : 0
  device_name   = "/dev/sdj"
  volume_id     = "${aws_ebs_volume.jenkins.id}"
  instance_id   = "${aws_instance.jenkins[0].id}"
}
