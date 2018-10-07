
################ ################################################## ########
################ Module [[[security group]]] Output Variables List. ########
################ ################################################## ########

### ################################# ###
### [[output]] out_security_group_ids ###
### ################################# ###

output out_security_group_ids
{
    description = "One element list with ID of either the default security group or the new one."
    value       = [ "${ var.in_use_default ? aws_default_security_group.default.*.id : aws_security_group.new.*.id }" ]
}


### ################################ ###
### [[output]] out_security_group_id ###
### ################################ ###

output out_security_group_id
{
    description = "The string ID of either the default security group or the just created new one."
    value       = "${ var.in_use_default ? aws_default_security_group.default.*.id : aws_security_group.new.*.id }"
}
