
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


### ############################ ###
### [[variable]] in_ecosystem_id ###
### ############################ ###

variable in_ecosystem_id
{
    description = "Identifier binding all infrastructure components created for this ecosystem instance."
}


### ############################ ###
### [[variable]] in_history_note ###
### ############################ ###

variable in_history_note
{
    description = "Note describing the whys and wherefores of this creation."
}


### ######################################### ###
### [[output]] out_default_security_group_ids ###
### ######################################### ###

output out_default_security_group_ids
{
    description = "If in_use_default is true this output variable will be set."
# ---@----@-->    value       = "${aws_default_security_group.default.*.id}"
    value       = "${aws_default_security_group.default.id}"
}


# ---@----@-->### ############################# ###
# ---@----@-->### [[output]] out_new_security_group_ids ###
# ---@----@-->### ############################# ###
# ---@----@-->output "out_new_security_group_ids"
# ---@----@-->{
# ---@----@-->    description = "If in_use_default is false this output variable will be set."
# ---@----@-->    value       = "${aws_security_group.sgroup-new.*.id}"
# ---@----@-->}

