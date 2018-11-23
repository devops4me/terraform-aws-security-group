
################ ################################################## ########
################ Module [[[security group]]] Output Variables List. ########
################ ################################################## ########


/*
 | --
 | -- element: element() may not be used with an empty list
 | --
 | --
*/
output out_security_group_id
{
    description = "The string ID of either the default security group or the just created new one."
#######    value       = "${ var.in_use_default ? element( aws_default_security_group.default.*.id, 0 ) : element( aws_security_group.new.*.id, 0 ) }"
    value       = "${ var.in_use_default ? element( concat( aws_default_security_group.default.*.id, list("") ), 0 ) : element( concat( aws_security_group.new.*.id, list("") ), 0 ) }"
}


########### public_ip_address_id = "${length(azurerm_public_ip.virtual_machine_public_ip.*.id) > 0 ? element(concat(azurerm_public_ip.virtual_machine_public_ip.*.id, list("")), count.index) : ""}"
