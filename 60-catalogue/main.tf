resource "aws_instance" "catalogue" {
  ami_id = data.aws_ami.joindevops.id
  instance_type           = "t3.micro"
  vpc_security_group_ids   = [local.catalogue_sg_id] 
  subnet_id  = local.private_subnet_id
  tags = merge (
    local.common_tags,
    {
        Name    =   "${local.common_name_suffix}-catalogue"
    }
  )
}


resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  ## Terraform copies this file to mysql server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }


  provisioner "remote-exec" {
    inline  =   [
        "chmod +X /tmp/bootstrap.sh",
        # "sudo sh /tmp/bootstrap.sh"
        "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
  }
}