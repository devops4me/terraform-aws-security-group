
################ ######################################## ########
################ Module [[[rules]]] Input Variables List. ########
################ ######################################## ########

### ####################### ###
### [[variable]] in_ingress ###
### ####################### ###

variable in_ingress
{
    description = "4 element list defining traffic to allow in (see traffic-rules.tf)"
    type        = "list"
    default     = [ "ssh" ]
}


### ###################### ###
### [[variable]] in_egress ###
### ###################### ###

variable in_egress
{
    description = "4 element list defining traffic to allow out (see traffic-rules.tf)"
    type        = "list"
    default = [ "all-traffic" ]
}


### ###################### ###
### [[variable]] in_vpc_id ###
### ###################### ###

variable in_vpc_id
{
    description = "umbrella vpc the security group falls under which reverts to the default VPC if not set."
    default     = ""
}


### ################################### ###
### [[variable]] in_ingress_cidr_blocks ###
### ################################### ###

variable in_ingress_cidr_blocks
{
    description = "The IPv4 CIDR ranges from which traffic is allowed to originate."
    type        = "list"
    default     = [ "0.0.0.0/0" ]
}


### ################################## ###
### [[variable]] in_egress_cidr_blocks ###
### ################################## ###

variable in_egress_cidr_blocks
{
    description = "List of IPv4 CIDR ranges to use on all egress rules"
    type        = "list"
    default     = [ "0.0.0.0/0" ]
}


### ########################### ###
### [[variable]] in_use_default ###
### ########################### ###

variable in_use_default
{
    description = "By default rules are added to the default security group - false creates one first."
    default = true
}

### ######################### ###
### [[variable]] in_ecosystem ###
### ######################### ###

variable in_ecosystem
{
    description = "The name of the class of ecosystem being built like kubernetes-cluster or rabbit-mq"
    default     = "eco-system"
}
