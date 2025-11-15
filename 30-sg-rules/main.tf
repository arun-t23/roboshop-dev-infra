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

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id ## traffic to Database redis from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  security_group_id = local.rabbitmq_sg_id ## traffic to Database redis from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id ## traffic to Database mysql from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id ## traffic to Database catalogue from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id ## traffic to Database mysql from Catalogue
  source_security_group_id  = local.catalogue_sg_id
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

resource "aws_security_group_rule" "catalogue_backend-alb" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id ## request from backednd ALB goes to catalogue target group for health check on port 8080
  source_security_group_id  = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}


resource "aws_security_group_rule" "frontend_alb_public" {
  type              = "ingress"
  security_group_id = local.frontend_alb_sg_id ## traffic to alb from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  security_group_id = local.mongodb_alb_sg_id ## traffic to mongodb from user
  source_security_group_id  = local.user_sg_id
  from_port         = 27017
  protocol          = "tcp"
  to_port           = 27017
}

resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  security_group_id = local.redis_alb_sg_id ## traffic to redis from user
  source_security_group_id  = local.user_sg_id
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
}

resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  security_group_id = local.redis_alb_sg_id ## traffic to redis from cart
  source_security_group_id  = local.cart_sg_id
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
}

resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  security_group_id = local.mysql_alb_sg_id ## traffic to mysql from shipping
  source_security_group_id  = local.shipping_sg_id
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  security_group_id = local.mysql_alb_sg_id ## traffic to rabbitmq from payment
  source_security_group_id  = local.shipping_sg_id
  from_port         = 5672
  protocol          = "tcp"
  to_port           = 5672
}

resource "aws_security_group_rule" "user_backend-alb" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id ## request from backednd ALB goes to user target group for health check on port 8080
  source_security_group_id  = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "cart_backend-alb" {
  type              = "ingress"
  security_group_id = local.cart_sg_id ## request from backednd ALB goes to cart target group for health check on port 8080
  source_security_group_id  = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "shipping_backend-alb" {
  type              = "ingress"
  security_group_id = local.shipping_sg_id ## request from backednd ALB goes to shipping target group for health check on port 8080
  source_security_group_id  = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "payment_backend-alb" {
  type              = "ingress"
  security_group_id = local.payment_sg_id ## request from backednd ALB goes to payment target group for health check on port 8080
  source_security_group_id  = local.backend_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "catalogue_cart" {
  type              = "ingress"
  security_group_id = local.catalogue_sg_id
  source_security_group_id  = local.cart_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "cart_shipping" {
  type              = "ingress"
  security_group_id = local.cart_sg_id
  source_security_group_id  = local.shipping_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "user_payment" {
  type              = "ingress"
  security_group_id = local.user_sg_id
  source_security_group_id  = local.payment_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}
resource "aws_security_group_rule" "cart_payment" {
  type              = "ingress"
  security_group_id = local.cart_sg_id
  source_security_group_id  = local.payment_alb_sg_id
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
}

resource "aws_security_group_rule" "backend_alb_frontend" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id  = local.frontend_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = local.frontend_sg_id
  source_security_group_id  = local.frontend_alb_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

