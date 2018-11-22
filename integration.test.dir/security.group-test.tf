
locals
{
    ecosystem_id = "sgrules-test"
}

module zero-paramaters
{
    source = ".."
}

module virtual-private-cloud-1
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.123.0.0/16"
    in_ecosystem = "${ local.ecosystem_id }"
}

module security-group-test-1
{
    source         = ".."
    in_ingress     = [ "ssh", "http", "https" ]
    in_vpc_id      = "${ module.virtual-private-cloud-1.out_vpc_id }"
    in_use_default = "true"
    in_ecosystem   = "${ local.ecosystem_id }-01"
}

module virtual-private-cloud-2
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.124.0.0/16"
    in_ecosystem = "${ local.ecosystem_id }"
}

module security-group-test-2
{
    source         = ".."
    in_ingress     = [ "elasticsearch", "ssh", "java" ]
    in_egress      = [ "all-traffic" ]
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"
    in_use_default = "true"
    in_ecosystem   = "${ local.ecosystem_id }-02"
}

# = ===
# = This security group test
#      - does not specify egress rules (expecting all-traffic default).
#      - latches onto the default VPC security group ( in_use_default = true )
# = ===
module security-group-test-3
{
    source         = "github.com/devops4me/terraform-aws-security-group"
    in_ingress     = [ "ssh", "http", "https" ]
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"
    in_use_default = "true"
    in_ecosystem   = "${ local.ecosystem_id }"
}

output security_group_id
{
    value = "${module.security-group-test-1.out_security_group_id}"
}
