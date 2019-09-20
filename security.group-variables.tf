
################ ######################################## ########
################ Module [[[rules]]] Input Variables List. ########
################ ######################################## ########

### ####################### ###
### [[variable]] in_ingress ###
### ####################### ###

variable in_ingress {

    description = "4 element list defining traffic to allow in (see traffic-rules.tf)"
    type        = list
    default     = [ "ssh" ]
}


### ###################### ###
### [[variable]] in_egress ###
### ###################### ###

variable in_egress {

    description = "4 element list defining traffic to allow out (see traffic-rules.tf)"
    type        = list
    default = [ "all-traffic" ]
}


### ###################### ###
### [[variable]] in_vpc_id ###
### ###################### ###

variable in_vpc_id {

    description = "Mandatory umbrella vpc the security group falls under which reverts to the default VPC if not set."
    type = string
}


### ################################### ###
### [[variable]] in_ingress_cidr_blocks ###
### ################################### ###

variable in_ingress_cidr_blocks {

    description = "The IPv4 CIDR ranges from which traffic is allowed to originate."
    type        = list
    default     = [ "0.0.0.0/0" ]
}


### ################################## ###
### [[variable]] in_egress_cidr_blocks ###
### ################################## ###

variable in_egress_cidr_blocks {

    description = "List of IPv4 CIDR ranges to use on all egress rules"
    type        = list
    default     = [ "0.0.0.0/0" ]
}


### ############################## ###
### [[variable]] in_mandated_tags ###
### ############################## ###

variable in_mandated_tags {

    description = "Optional tags unless your organization mandates that a set of given tags must be set."
    type        = map
    default     = { }
}


### ################# ###
### in_ecosystem_name ###
### ################# ###

variable in_ecosystem_name {

    description = "Creational stamp binding all infrastructure components created on behalf of this ecosystem instance."
}


### ################ ###
### in_tag_timestamp ###
### ################ ###

variable in_tag_timestamp {

    description = "A timestamp for resource tags in the format ymmdd-hhmm like 80911-1435"
}


### ################## ###
### in_tag_description ###
### ################## ###

variable in_tag_description {

    description = "Ubiquitous note detailing who, when, where and why for every infrastructure component."
}
