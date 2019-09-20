
/*
 | --
 | -- If you are using an IAM role as the AWS access mechanism then
 | -- pass it as in_role_arn commonly through an environment variable
 | -- named TF_VAR_in_role_arn in addition to the usual AWS access
 | -- key, secret key and default region parameters.
 | --
*/
provider aws {
    dynamic assume_role {
        for_each = length( var.in_role_arn ) > 0 ? [ var.in_role_arn ] : [] 
        content {
            role_arn = assume_role.value
	}
    }
}


/*
 | --
 | -- Terraform will tag every significant resource allowing you to report and collate
 | --
 | --   [1] - all infrastructure in all environments dedicated to your app (ecosystem_name)
 | --   [2] - the infrastructure dedicated to this environment instance (timestamp)
 | --
*/
locals {
    ecosystem_name = "security-grp-ex"
    timestamp = formatdate( "YYMMDDhhmmss", timestamp() )
    date_time = formatdate( "EEEE DD-MMM-YY hh:mm:ss ZZZ", timestamp() )
    description = "was created by me on ${ local.date_time }."
}


### ############################## ###
### Example Security Group Modules ###
### ############################## ###

module virtual-private-cloud-1 {

    source  = "devops4me/vpc-network/aws"
    version = "~> 1.0.3"

    in_vpc_cidr  = "10.123.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false

    in_ecosystem   = "${ local.ecosystem_name }-01"
    in_timestamp   = local.timestamp
    in_description = local.description
}

module security-group-test-1a {

    source         = "./.."
    in_vpc_id      = module.virtual-private-cloud-1.out_vpc_id
    in_ingress     = [ "docker", "java" ]

    in_ecosystem   = "${ local.ecosystem_name }-1a"
    in_timestamp   = local.timestamp
    in_description = local.description
}

module security-group-test-1b {

    source         = "./.."
    in_vpc_id      = module.virtual-private-cloud-1.out_vpc_id
    in_ingress     = [ "ssh", "http", "https" ]

    in_ecosystem   = "${ local.ecosystem_name }-1b"
    in_timestamp   = local.timestamp
    in_description = local.description
}

module virtual-private-cloud-2 {

    source  = "devops4me/vpc-network/aws"
    version = "~> 1.0.3"

    in_vpc_cidr  = "10.124.0.0/16"
    in_create_private_gateway = false
    in_create_public_gateway  = false

    in_ecosystem     = "${ local.ecosystem_name }-02"
    in_timestamp   = local.timestamp
    in_description = local.description
}

module security-group-test-2a {

    source         = "./.."
    in_ingress     = [ "https", "ssh", "jenkins" ]
    in_egress      = [ "all-traffic" ]
    in_vpc_id      = module.virtual-private-cloud-2.out_vpc_id

    in_ecosystem   = "${ local.ecosystem_name }-2a"
    in_timestamp   = local.timestamp
    in_description = local.description
}

module security-group-test-2b {

    source         = "./.."
    in_vpc_id      = module.virtual-private-cloud-2.out_vpc_id
    in_ingress     = [ "sonar", "postgres", "ecs" ]

    in_ecosystem   = "${ local.ecosystem_name }-2b"
    in_timestamp   = local.timestamp
    in_description = local.description
}
