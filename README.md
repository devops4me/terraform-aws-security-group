
# Create Security Group Rules | Terraform Module

**You avoid hundreds of lines of similar security group definitions** by using this rule creation module.

In **just one line** with words like **ssh**, **https**, **sftp**, **rabbitmq**, **openvpn** or **all-traffic** you specify every AWS security group rule that you need. This module always creates a new security group because **Terraform cannot correctly adopt the VPC's default security group** - it exhibits problems setting the descriptions and fails as it attempts to destroy it.

## Usage

    module security_group {

        source  = "devops4me/security-group/aws"
        version = "~> 1.0.3"

        in_ingress = [ "ssh", "http", "https" ]
        in_vpc_id  = module.vpc.out_vpc_id
    }

    resource aws_instance ec2
    {
        vpc_security_group_ids = [ module.security_group.out_security_group_id ]
    }

**out_security_group_id** is the fundamental module output **string** variable.


---


## [Run the Example](https://github.com/devops4me/terraform-aws-security-group/tree/master/example)

You can run the example to see this module create a number of VPCs with varying attributes such as the number of private/public subnets.



## Use Case

What is the use case flow at the heart of this security group rule creation module?

- a **VPC is mandatorily provided**
- a **new security group is created**
- **ingress and egress rules are added to the security group**
- the default source (and/or destination) of 0.0.0.0/0 is used
- the rules can apply the specified IP address ranges (through CIDR blocks for the source and/or destination of traffic to allow.


---


## Module Inputs

The security group's input variables are vital to achieving the desired behaviour.

| Imported | Type | Default | Comment |
|:-------- |:----:|:------- |:------- |
**`in_vpc_id`** | string | vpc-1234567890 | create security group/s under VPC with this id
**`in_ingress`** | list | [ "postgres", "https"] | identify the ports to allow for inbound traffic
**`in_egress`** | list | [ "all-traffic" ] | identify the ports to allow for outbound traffic
**`in_ingress_cidr_blocks`** | list | [ "0.0.0.0/0"] | list of source incoming traffic addresses to allow
**`in_egress_cidr_blocks`** | list | [ "0.0.0.0/0"] | list of VPC source outgoing traffic addresses to allow
**`in_ecosystem`** | string | kube-19188-2306 | the ecosystem's identifier including a timestamp

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


### Optional Resource Tag Inputs

Most organisations have a mandatory set of tags that must be placed on AWS resources for cost and billing reports. Typically they denote owners and specify whether environments are prod or non-prod.

| Input Variable    | Variable Description | Input Example
|:----------------- |:-------------------- |:----- |
**`in_ecosystem`** | the ecosystem (environment) name these resources belong to | **`my-app-test`** or **`kubernetes-cluster`**
**`in_timestamp`** | the timestamp in resource names helps you identify which environment instance resources belong to | **`1911021435`** as **`$(date +%y%m%d%H%M%S)`**
**`in_description`** | a human readable description usually stating who is creating the resource and when and where | "was created by $USER@$HOSTNAME on $(date)."

Try **`echo $(date +%y%m%d%H%M%S)`** to check your timestamp and **`echo "was created by $USER@$HOSTNAME on $(date)."`** to check your description. Here is how you can send these values to terraform.

```
export TF_VAR_in_timestamp=$(date +%y%m%d%H%M%S)
export TF_VAR_in_description="was created by $USER@$HOSTNAME on $(date)."
```


---


## Module Outputs

| Exported                 | Type   | Comment |
|:------------------------ |:------ |:------- |
**`out_security_group_id`**  | String | ID of the security group that contains the specified rules
