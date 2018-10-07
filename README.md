
# Create Security Group Rules | Terraform Module

**Avoid hundreds of lines of similar security group definitions** by refactoring to use this security group and rule creation terraform module.

You specify every ingress rule you need in just one line with words like **ssh**, https, **sftp**, rabbitmq, **kube-control-plane** or openvpn. If you omit in_egress the ubiquitous "all-traffic" is assumed.

## Usage

    module security_group
    {
        source     = "github.com/devops-ip/terraform-aws-security-group"
        in_ingress = [ "ssh", "http", "https" ]
        in_vpc_id  = "${module.vpc.vpc_id}"
    }

    resource aws_instance ec2-instance
    {
        ami = "${var.ubuntu-amis[ "${data.aws_region.with.name}" ]}"
        instance_type = "t2.micro"

        vpc_security_group_ids = "${module.security_group.out_security_group_ids}"
    }

Output **out_security_group_ids** is a **list** whilst **out_security_group_id** is a **string**.

## [Examples and Tests](test-security.group)

**[This terraform module has runnable example integration tests](test-security.group)**. Read the instructions on how to clone the project and run the integration tests.


## Use Case

What is the use case flow at the heart of this security group rule creation module?

- a **VPC is provided** (or the default one is used)
- a **security group is created** (or the default one for the VPC is used)
- **ingress and egress rules are added to the security group**
- the default source (and/or destination) of 0.0.0.0/0 is used
- the rules can apply to specific supplied (source and/or destination) addresses


## Inputs

The security group's input variables are vital to achieving the desired behaviour.

| Imported | Type | Default | Comment |
|:-------- |:---- |:------- |:------- |
**in_vpc_id** | String | vpc-1234567890 | create security group/s under VPC with this id
**in_use_default** | Boolean | [ true ] | use the default security group if true else create one
**in_ingress** | List | [ "postgres", "https"] | identify the ports to allow for inbound traffic
**in_egress** | List | [ "all-traffic" ] | identify the ports to allow for outbound traffic
**in_ingress_cidr_blocks** | List | [ "0.0.0.0/0"] | list of source incoming traffic addresses to allow
**in_egress_cidr_blocks** | List | [ "0.0.0.0/0"] | list of VPC source outgoing traffic addresses to allow
**in_ecosystem** | String | kube-19188-2306 | the ecosystem's identifier including a timestamp

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

### Contributing

Bug reports and pull requests are welcome on GitHub at the https://github.com/devops-ip/terraform-aws-vpc-subnets page. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

License
-------

MIT License
Copyright (c) 2006 - 2014

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
