
### ####################################### ###
### [[resource]] aws_default_security_group ###
### ####################################### ###

resource aws_security_group new
{
    count = "${ var.in_use_default ? 1 : 0 }"

    name        = "security-group-${ var.in_ecosystem }-${ module.ecosys.out_stamp }-n"
    description = "This new security group ${ module.ecosys.out_history_note }"
    vpc_id      = "${var.in_vpc_id}"

    tags
    {
        Name   = "security-group-${ var.in_ecosystem }-${ module.ecosys.out_stamp }-n"
        Class = "${ var.in_ecosystem }"
        Instance = "${ var.in_ecosystem }-${ module.ecosys.out_stamp }"
        Desc   = "Newly created security group for ${ var.in_ecosystem } ${ module.ecosys.out_history_note }"
    }

}


### ####################################### ###
### [[resource]] aws_default_security_group ###
### ####################################### ###

resource aws_default_security_group default
{
    vpc_id      = "${var.in_vpc_id}"

    tags
    {
        Name   = "security-group-${ var.in_ecosystem }-${ module.ecosys.out_stamp }-d"
        Class = "${ var.in_ecosystem }"
        Instance = "${ var.in_ecosystem }-${ module.ecosys.out_stamp }"
        Desc   = "The default security group in the VPC for ${ var.in_ecosystem } ${ module.ecosys.out_history_note }"
    }

}


### #################################### ###
### [[resource]] aws_security_group_rule ###
### #################################### ###

resource aws_security_group_rule ingress
{
    count = "${length(var.in_ingress)}"

# ---@----@-->    security_group_id = "${var.in_use_default == true ? aws_default_security_group.default.id : aws_security_group.sgroup-new.id}"
    security_group_id = "${aws_default_security_group.default.id}"

    type        = "ingress"
    cidr_blocks = ["${var.in_ingress_cidr_blocks}"]
    description = "${element(var.rules[var.in_ingress[count.index]], 3)}"

    from_port   = "${element(var.rules[var.in_ingress[count.index]], 0)}"
    to_port     = "${element(var.rules[var.in_ingress[count.index]], 1)}"
    protocol    = "${element(var.rules[var.in_ingress[count.index]], 2)}"
}

### #################################### ###
### [[resource]] aws_security_group_rule ###
### #################################### ###

resource aws_security_group_rule egress
{
    count = "${length(var.in_egress)}"

# ---@----@-->    security_group_id = "${var.in_use_default == true ? aws_default_security_group.default.id : aws_security_group.sgroup-new.id}"
    security_group_id = "${aws_default_security_group.default.id}"

    type        = "egress"
    cidr_blocks = ["${var.in_egress_cidr_blocks}"]
    description = "${element(var.rules[var.in_egress[count.index]], 3)}"

    from_port   = "${element(var.rules[var.in_egress[count.index]], 0)}"
    to_port     = "${element(var.rules[var.in_egress[count.index]], 1)}"
    protocol    = "${element(var.rules[var.in_egress[count.index]], 2)}"
}


### ################# ###
### [[module]] ecosys ###
### ################# ###

module ecosys
{
    source = "github.com/devops-ip/terraform-aws-stamps"
}
