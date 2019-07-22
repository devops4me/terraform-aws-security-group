
/*
 | --
 | -- This is the main security group resource for aggregating the
 | -- ingress and egress rules. It is important for now to always
 | -- create another security group as Terraform cannot easily handle
 | -- importing and changing the VPC's default security group.
*/
resource aws_security_group new {

    vpc_id      = "${ var.in_vpc_id }"
    name        = "security-group-${ var.in_ecosystem_name }-${ var.in_tag_timestamp }-n"
    description = "This new security group ${ var.in_tag_description }"

    tags = {

        Name     = "security-group-${ var.in_ecosystem_name }-${ var.in_tag_timestamp }"
        Class    = "${ var.in_ecosystem_name }"
        Instance = "${ var.in_ecosystem_name }-${ var.in_tag_timestamp }"
        Desc     = "New security group for ${ var.in_ecosystem_name } ${ var.in_tag_description }"
    }

}


/*
 | --
 | -- Add the incoming ingress rules to the aggregating security
 | -- group. The cidr blocks define the source from which traffic
 | -- can flow. You can pass in 0.0.0.0/0 for anywhere but also
 | -- specify IP address ranges right down to a single host.
*/
resource aws_security_group_rule ingress {

    count = "${length(var.in_ingress)}"

    security_group_id = "${ aws_security_group.new.id }"

    type        = "ingress"
    cidr_blocks = ["${var.in_ingress_cidr_blocks}"]
    description = "${element(var.rules[var.in_ingress[count.index]], 3)}"

    from_port   = "${element(var.rules[var.in_ingress[count.index]], 0)}"
    to_port     = "${element(var.rules[var.in_ingress[count.index]], 1)}"
    protocol    = "${element(var.rules[var.in_ingress[count.index]], 2)}"
}


/*
 | --
 | -- Add the outgoing egress rules to the aggregating security
 | -- group. The cidr blocks define the destinations to which traffic
 | -- can flow. You can pass in 0.0.0.0/0 for anywhere or you can
 | -- specify IP address ranges right down to a single destined host.
*/
resource aws_security_group_rule egress {

    count = "${length(var.in_egress)}"

    security_group_id = "${ aws_security_group.new.id }"

    type        = "egress"
    cidr_blocks = ["${var.in_egress_cidr_blocks}"]
    description = "${element(var.rules[var.in_egress[count.index]], 3)}"

    from_port   = "${element(var.rules[var.in_egress[count.index]], 0)}"
    to_port     = "${element(var.rules[var.in_egress[count.index]], 1)}"
    protocol    = "${element(var.rules[var.in_egress[count.index]], 2)}"
}
