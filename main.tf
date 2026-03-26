resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.sg]
  tags = {
    Name = "github-runner"
  }
}

resource "null_resource" "provisioner" {
  depends_on = [
    aws_instance.instance
  ]
  triggers = {
    timestamp = timestamp()
    instance_id = aws_instance.instance.id
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }
    inline = [
      "sudo dnf install python3.11-pip -y",
      "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/pdevops87/github-actions-ci runner.yaml -e URL=${var.URL} -e TOKEN=${var.TOKEN}"
    ]
  }
}

