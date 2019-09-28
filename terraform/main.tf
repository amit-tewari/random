variable "enable_jenkins_instance" {
  description   = "If set to true, create Jenkins instance and attach persistant volume"
  type          = bool
  default       = false
}

resource "aws_ebs_volume" "jenkins" {
  enabled               = true
  availability_zone     = "us-west-2a"
  size                  = 8
  encrypted             = true

  tags = {
    content = "jenkins-data"
  }
}

resource "aws_instance" "jenkins" {
  enabled               = var.enable_jenkins_instance
  ami                   = "ami-21f78e11"
  availability_zone     = "us-west-2a"
  instance_type         = "t1.micro"

  tags = {
    Name = "jenkins"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  enabled       = var.enable_jenkins_instance
  device_name   = "/dev/sdj"
  volume_id     = "${aws_ebs_volume.jenkins.id}"
  instance_id   = "${aws_instance.jenkins.id}"
}
