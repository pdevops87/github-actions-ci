resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.sg]
  tags = {
    Name = each.key
  }
}

resource "null_resource" "provisioner" {
  for_each      = var.components
  depends_on = [
    aws_instance.instance
  ]
  triggers = {
    timestamp = timestamp()
    instance_id = aws_instance.instance[each.key].id
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instance[each.key].private_ip
    }
    inline = [
      "sudo dnf install python3.11-pip -y",
      "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/pdevops87/github-actions-ci roboshop.yaml -e ORG=${each.key} -e TOKEN=${var.TOKEN} -e NAME=${var.NAME}"
    ]
  }
}

