
### ################################################# ###
### [[test-module]] testing terraform-aws-vpc-subnets ###
### ################################################# ###

locals
{
    ecosystem_id = "vs-unittest"
}

module zero-param-test
{
    source = "github.com/devops-ip/terraform-aws-vpc-subnets"
}

module last-stable-release-test-0
{
    source       = "github.com/devops-ip/terraform-aws-vpc-subnets?ref=v0.1.0002"
    in_vpc_cidr  = "10.234.56.0/24"
    in_ecosystem = "${local.ecosystem_id}-00"
}

module vpc-subnets-test-1
{
    source       = "github.com/devops-ip/terraform-aws-vpc-subnets"
    version      = "v0.1.0002"
    in_vpc_cidr  = "10.234.0.0/16"
    in_ecosystem = "${local.ecosystem_id}-01"
}

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

output subnet_ids_1{ value = "${module.vpc-subnets-test-1.out_subnet_ids}" }
output private_subnet_ids_1{ value = "${module.vpc-subnets-test-1.out_private_subnet_ids}" }
output public_subnet_ids_1{ value = "${module.vpc-subnets-test-1.out_public_subnet_ids}" }

output subnet_ids_2{ value = "${module.vpc-subnets-test-6.out_subnet_ids}" }
output private_subnet_ids_2{ value = "${module.vpc-subnets-test-6.out_private_subnet_ids}" }
output public_subnet_ids_2{ value = "${module.vpc-subnets-test-6.out_public_subnet_ids}" }

output subnet_ids_3{ value = "${module.vpc-subnets-test-7.out_subnet_ids}" }
output private_subnet_ids_3{ value = "${module.vpc-subnets-test-7.out_private_subnet_ids}" }
output public_subnet_ids_3{ value = "${module.vpc-subnets-test-7.out_public_subnet_ids}" }

output subnet_ids_4{ value = "${module.vpc-subnets-test-9.out_subnet_ids}" }
output private_subnet_ids_4{ value = "${module.vpc-subnets-test-9.out_private_subnet_ids}" }
output public_subnet_ids_4{ value = "${module.vpc-subnets-test-9.out_public_subnet_ids}" }
