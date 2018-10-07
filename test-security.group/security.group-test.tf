
### ################################################# ###
### [[test-module]] testing terraform-aws-vpc-subnets ###
### ################################################# ###

locals
{
    ecosystem_id = "sgrules-test"
}

module vpc-subnets
{
    source       = "github.com/devops-ip/terraform-aws-vpc-subnets"
    in_vpc_cidr  = "10.123.0.0/16"
    in_ecosystem = "${ local.ecosystem_id }"
}

module zero-param-test
{
    source = "github.com/devops-ip/terraform-aws-security-group"
}

/*
module last-stable-release-test-0
{
    source       = "github.com/devops-ip/terraform-aws-security-group?ref=v0.1.0001"
    in_ingress   = [ "ssh", "http", "https" ]
    in_ecosystem = "${local.ecosystem_id}-00"
}
*/

module security-group-test-1
{
    source       = "github.com/devops-ip/terraform-aws-security-group"
    version      = "v0.1.0001"
    in_vpc_id    = "${ module.vpc-subnets.out_vpc_id }"
    in_ecosystem = "${ local.ecosystem_id }-01"
}

/*
module vpc-subnets-test-2
{
    source         =  "github.com/devops-ip/terraform-aws-vpc-subnets"
    version        =  "~> v0.1.0"
    in_vpc_cidr    =  "10.15.0.0/18"
    in_subnets_max =  "4"
    in_ecosystem   =  "${local.ecosystem_id}-02"
}

module vpc-subnets-test-3
{
    source          = "github.com/devops-ip/terraform-aws-vpc-subnets"
    in_vpc_cidr     = "10.63.0.0/20"
    in_subnets_max  = "6"
    in_ecosystem    = "${local.ecosystem_id}-03"
}

module vpc-subnets-test-4
{
    source                 = "github.com/devops-ip/terraform-aws-vpc-subnets"
    in_vpc_cidr            = "10.255.0.0/21"
    in_num_private_subnets = 8
    in_num_public_subnets  = 7
    in_subnets_max         = "7"
    in_ecosystem           = "${local.ecosystem_id}-04"
}

module vpc-subnets-test-5
{
    source                 = "github.com/devops-ip/terraform-aws-vpc-subnets"
    in_vpc_cidr            = "10.242.0.0/16"
    in_num_private_subnets = 0
    in_num_public_subnets  = 0
    in_ecosystem           = "${local.ecosystem_id}-05"
}

module vpc-subnets-test-6
{
    source                 = "github.com/devops-ip/terraform-aws-vpc-subnets"
    in_vpc_cidr            = "10.243.0.0/16"
    in_num_private_subnets = 0
    in_ecosystem           = "${local.ecosystem_id}-06"
}

module vpc-subnets-test-7
{
    source                = ".."
    in_vpc_cidr           = "10.244.0.0/16"
    in_num_public_subnets = 0
    in_ecosystem          = "${local.ecosystem_id}-07"
}

module vpc-subnets-test-8
{
    source                 = ".."
    in_vpc_cidr            = "10.245.0.0/16"
    in_num_private_subnets = 6
    in_num_public_subnets  = 6
    in_ecosystem           = "${local.ecosystem_id}-08"
}

module vpc-subnets-test-9
{
    source                 = ".."
    in_vpc_cidr            = "10.31.0.0/22"
    in_num_private_subnets = 2
    in_num_public_subnets  = 8
    in_subnets_max         = "5"
    in_ecosystem           = "${local.ecosystem_id}-09"
}

*/


output subnet_ids_1{ value = "${module.vpc-subnets.out_subnet_ids}" }
output private_subnet_ids_1{ value = "${module.vpc-subnets.out_private_subnet_ids}" }
output public_subnet_ids_1{ value = "${module.vpc-subnets.out_public_subnet_ids}" }

output security_group_id_1 { value = "${module.security-group-test-1.out_security_group_id}"  }
output security_group_ids_1{ value = "${module.security-group-test-1.out_security_group_ids}" }
