resource "aws_instance" "mongodb" {
  ami               = local.ami_id
  instance_type     = "t3.micro"
  vpc_security_group_ids   = [local.mongodb_sg_id] 
  subnet_id  = local.database_subnet_id
  tags = merge (
    local.common_tags,
    {
        Name    =   "${local.common_name_suffix}-mongodb"
    }
  )
}


resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.root_password
    host     = aws_instance.mongodb.private_ip
  }

  ## Terraform copies this file to mongodb server
  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }



  provisioner "remote-exec" {
    inline  =   [
        "chmod +X /tmp/bootstrap.sh",
        # "sudo sh /tmp/bootstrap.sh"
        "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}


# resource "aws_instance" "redis" {
#   ami               = local.ami_id
#   instance_type     = "t3.micro"
#   vpc_security_group_ids   = [local.redis_sg_id] 
#   subnet_id  = local.database_subnet_id
#   tags = merge (
#     local.common_tags,
#     {
#         Name    =   "${local.common_name_suffix}-redis"
#     }
#   )
# }


# resource "terraform_data" "redis" {
#   triggers_replace = [
#     aws_instance.redis.id
#   ]

# connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = var.root_password
#     host     = aws_instance.redis.private_ip
#   }

#   ## Terraform copies this file to mongodb server
#   provisioner "file" {
#     source = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }



#   provisioner "remote-exec" {
#     inline  =   [
#         "chmod +X /tmp/bootstrap.sh",
#         # "sudo sh /tmp/bootstrap.sh"
#         "sudo sh /tmp/bootstrap.sh redis"
#     ]
#   }
# }


