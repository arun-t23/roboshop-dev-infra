resource "aws_instance" "catalogue" {
  ami               = local.ami_id
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
        "chmod +X /tmp/catalogue.sh",
        # "sudo sh /tmp/bootstrap.sh"
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on   =    [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on    =   [aws_ec2_instance_state.catalogue]
  tags = merge (
    local.common_tags,
    {
        Name    =   "${local.common_name_suffix}-catalogue"
    }
  )
}