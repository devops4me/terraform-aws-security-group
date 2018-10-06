
# Create Security Group Rules | Terraform Module

Refactor to use this module and avoid **hundreds of lines of very similar security group** terraform definitions.

## Usage

You specify every ingress rule you need in just one line with words like **ssh**, https, **sftp**, rabbitmq, kube-controller and **openvpn**. If you omit in_egress then the ubiquitous "all-traffic" is assumed.

 The most common usage is to specify the VPC ID and the ingress (inbound) rules To use this module simply declare it like below supplying it with a mandatory VPC id. If you omit **in_ingress** a default ssh rule is created. A default **all traffic egress rule** is also created but you can override this behaviour if you so wish.


    module security_groups
    {
        source     = "github.com/devops-ip/terraform-aws-security-groups"
        in_ingress = [ "ssh", "http", "https" ]
        in_vpc_id  = "${module.vpc.vpc_id}"
    }

    resource aws_instance ec2-instance
    {
        ami = "${var.ubuntu-amis[ "${data.aws_region.with.name}" ]}"
        instance_type = "t2.micro"

        vpc_security_group_ids = "${module.security_groups.out_security_group_ids}"
    }



This module defines two **list outputs** called **out_default_security_group_ids** and **out_new_security_group_ids**. Use the first after creating rules against the VPC's default security group and the second after a new security group is created (see variable in_use_default).

    vpc_security_group_ids = [ "${module.security_group_module.out_default_security_group_ids}" ]

## Security Group Module Inputs

The security group's input variables are vital to achieving the desired behaviour.

| Imported | Type | Default | Comment |
|:-------- |:---- |:------- |:------- |
**in_vpc_id** | String | vpc-1234567890 | create security group/s under VPC with this id
**in_use_default** | Boolean | [ true ] | use the default security group if true else create one
**in_ingress** | List | [ "postgres", "https"] | identigy the ports to allow for inbound traffic
**in_egress** | List | [ "all-traffic" ] | identigy the ports to allow for outbound traffic
**in_ingress_cidr_blocks** | List | [ "0.0.0.0/0"] | list of source incoming traffic addresses to allow
**in_egress_cidr_blocks** | List | [ "0.0.0.0/0"] | list of VPC source outgoing traffic addresses to allow
**in_ecosystem_id** | String | kube-19188-2306 | the ecosystem's identifier including a timestamp

## Alternate Module Inputs

This security group module is simple but flexible as it needs to cater to many different tastes. Now follows a number of **overloading** facilities to craft your security group's behaviour.

### Specify the Creation of a Security Group
This security-group module **adds ingress and egress rules** to **either the default or a new** security group within a given VPC.


Passing **false** to the **in_use_default** flag causes the **creation of a security group**.

    module security_group_module
    {
        source     = "security"
        in_vpc_id  = "${module.xyz.out_vpc_id}"
        in_ingress = [ "ssh", "http", "https" ]
        in_egress  = [ "all-traffic" ]

        in_use_default = false
    }

Note that this module only creates one security group at a time. To create two or more simply repeat the module declaration using a different name each time.

### Specify Ingress and Egress Cidr Blocks

Most security group **source cidr blocks** allow traffic originating from anywhere ( 0.0.0.0/0 ).

This is true for both inress (incoming) and egress (outgoing) traffic. You can alter this by specifying these extra module inputs. The below allows traffic **in only from a given VPC** and **out only from a subnet** within the security group's VPC.

    in_ingress_cidr_blocks = [ "172.30.0.0/16" ]
    in_egress_cidr_blocks  = [ "10.2.0.4/24" ]

The cidr blocks are lists of strings so you can also allow traffic from more than one source block.

    in_ingress_cidr_blocks = [ "172.30.0.0/0", "82.9.72.144/31" ]

### Specify Other Ingress and Egress Rules

Clearly you will want to allow ingress and egress traffic for various middleware services.

> @todo Author then link to sister page containing a table full of rule classifications.

Note that if you create an all traffic egress rule and you have an **IPV6 cidr block**, AWS will create an extra **::/0** egress rule in addition to the 0.0.0.0/0 (IPV4) rule.

## Running the Module's Tests

Visit the README within the **ztest-security** folder for instructions on running this module's tests.

## Creating New Rule Groups

The outer list has no size restrictions but the inner list is expected to contain 4 elements.

- the port [from] which [inbound] traffic should be allowed
- the port [to] which [inbound] traffic should be allowed
- the ICMA protocol that the traffic obeys
- the (name) description of the traffic rule
