## Frontend accepting traffic from Frontend ALB 
resource "aws_security_group_rule" "backend_alb_bastion" {
    type              = "ingress"
  security_group_id = local.backend_alb_sg_id ## traffic to backend 
  source_security_group_id       = local.bastion_sg_id  ## traffic from bastion 
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "bastion_laptop" {
    type              = "ingress"
  security_group_id = local.bastion_sg_id ## traffic to BAstion 
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id ## traffic to Database mongodb from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}