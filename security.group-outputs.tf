
################ ################################################## ########
################ Module [[[security group]]] Output Variables List. ########
################ ################################################## ########

### ################################ ###
### [[output]] out_security_group_id ###
### ################################ ###

output out_security_group_id
{
    description = "The string ID of either the default security group or the just created new one."
    value       = "${ var.in_use_default ? element( aws_default_security_group.default.*.id, 0 ) : element( aws_security_group.new.*.id, 0 ) }"
}
