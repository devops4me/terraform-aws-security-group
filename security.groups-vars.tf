
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


### ###################### ###
### [[variable]] in_vpc_id ###
### ###################### ###

variable in_vpc_id
{
    description = "Mandatory VPC ID to create the security group under."
}


### ########################### ###
### [[variable]] in_use_default ###
### ########################### ###

variable in_use_default
{
    default = true
}


### ################################# ###
### [[output]] out_security_group_ids ###
### ################################# ###

output out_security_group_ids
{
    description = "One element list with ID of either the default security group or the new one."
    value       = [ "${ var.in_use_default ? aws_default_security_group.default.id : aws_security_group.new.id }" ]
}


### ################################ ###
### [[output]] out_security_group_id ###
### ################################ ###

output out_security_group_id
{
    description = "The string ID of either the default security group or the just created new one."
    value       = "${ var.in_use_default ? aws_default_security_group.default.id : aws_security_group.new.id }"
}


### ######################### ###
### [[variable]] in_ecosystem ###
### ######################### ###

variable in_ecosystem
{
    description = "The name of the class of ecosystem being built like kubernetes-cluster or elasticsearch-db."
    default     = "eco-system"
}
