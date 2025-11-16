
<<<<<<< HEAD

=======
>>>>>>> b8c6479633c1e075464dddfaf1fa9ca8a449f68d
variable "component" {
    default = "catalogue"
}

variable "rule_priority" {
    default = 10
}

variable "components" {
    default = {
        catalogue = {
            rule_priority = 10
        }
        user = {
            rule_priority = 20
        }
        cart = {
            rule_priority = 30
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        }
        frontend = {
            rule_priority = 10
        }
    }
}