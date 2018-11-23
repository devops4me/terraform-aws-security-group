
locals
{
    ecosystem_id = "sgrules-test"
}

module virtual-private-cloud-1
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.123.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false
    in_ecosystem = "${ local.ecosystem_id }-01"
}

module security-group-test-1a
{
    source         = ".."
    in_vpc_id      = "${ module.virtual-private-cloud-1.out_vpc_id }"
    in_ingress     = [ "elasticsearch", "java" ]
    in_use_default = false
    in_ecosystem   = "${ local.ecosystem_id }-1a"
}

module security-group-test-1b
{
    source         = ".."
    in_vpc_id      = "${ module.virtual-private-cloud-1.out_vpc_id }"
    in_ingress     = [ "ssh", "http", "https" ]
    in_use_default = true
    in_ecosystem   = "${ local.ecosystem_id }-1b"
}

module virtual-private-cloud-2
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.124.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false
    in_ecosystem = "${ local.ecosystem_id }-02"
}

module security-group-test-2a
{
    source         = ".."
    in_ingress     = [ "elasticsearch", "ssh", "java" ]
    in_egress      = [ "all-traffic" ]
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"
    in_use_default = true
    in_ecosystem   = "${ local.ecosystem_id }-2a"
}

# = ===
# = This security group test
#      - does not specify egress rules (expecting all-traffic default).
#      - latches onto the default VPC security group ( in_use_default = true )
# = ===
module security-group-test-2b
{
    source         = "github.com/devops4me/terraform-aws-security-group"
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"
    in_ingress     = [ "etcd-client", "etcd-server", "rabbitmq" ]
    in_use_default = false
    in_ecosystem   = "${ local.ecosystem_id }-2b"
}

output security_group_id_1a
{
    value = "${module.security-group-test-1a.out_security_group_id}"
}

output security_group_id_2b
{
    value = "${module.security-group-test-2b.out_security_group_id}"
}
