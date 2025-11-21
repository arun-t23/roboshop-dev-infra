variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable    "sg_names"{
    default =   [
        #databases
        "mongodb","mysql","redis","rabbitmq",
        # backend
        "catalogue","user","cart","shipping","payment",
        #frontend
        "frontend",
        #Bastion
        "bastion",
        #load balancer
        "frontend_alb",
        #backend-alb
        "backend_alb",
        "open_vpn"

    ]
}