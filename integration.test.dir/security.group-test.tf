
locals
{
    ecosystem_name = "sec-group-test"
}

module virtual-private-cloud-1
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.123.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false

    in_ecosystem_name     = "${ local.ecosystem_name }-01"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

module security-group-test-1a
{
    source         = ".."
    in_vpc_id      = "${ module.virtual-private-cloud-1.out_vpc_id }"
    in_ingress     = [ "elasticsearch", "java" ]

    in_ecosystem_name     = "${ local.ecosystem_name }-1a"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

module security-group-test-1b
{
    source         = ".."
    in_vpc_id      = "${ module.virtual-private-cloud-1.out_vpc_id }"
    in_ingress     = [ "ssh", "http", "https" ]

    in_ecosystem_name     = "${ local.ecosystem_name }-1b"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

module virtual-private-cloud-2
{
    source       = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr  = "10.124.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false

    in_ecosystem_name     = "${ local.ecosystem_name }-02"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

module security-group-test-2a
{
    source         = ".."
    in_ingress     = [ "elasticsearch", "ssh", "java" ]
    in_egress      = [ "all-traffic" ]
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"

    in_ecosystem_name     = "${ local.ecosystem_name }-2a"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

module security-group-test-2b
{
    source         = "github.com/devops4me/terraform-aws-security-group"
    in_vpc_id      = "${ module.virtual-private-cloud-2.out_vpc_id }"
    in_ingress     = [ "etcd-client", "etcd-server", "rabbitmq" ]

    in_ecosystem_name     = "${ local.ecosystem_name }-2b"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}

/*
 | --
 | -- Remember the AWS resource tags! Using this module, every
 | -- infrastructure component is tagged to tell you 5 things.
 | --
 | --   a) who (which IAM user) created the component
 | --   b) which eco-system instance is this component a part of
 | --   c) when (timestamp) was this component created
 | --   d) where (in which AWS region) was this component created
 | --   e) which eco-system class is this component a part of
 | --
*/
module resource-tags
{
    source = "github.com/devops4me/terraform-aws-resource-tags"
}

output security_group_id_1a
{
    value = "${module.security-group-test-1a.out_security_group_id}"
}

output security_group_id_2b
{
    value = "${module.security-group-test-2b.out_security_group_id}"
}
