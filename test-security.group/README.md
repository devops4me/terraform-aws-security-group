
# Integration Tests | Security Group Rules Terraform Module

You can [run the integration tests](security.group-test.tf) that are biased towards creating security group rules.

So what happens at the core of the security group integration tests?

- a **VPC is provided** (or the default one is used)
- a **security group is created** (or the default one for the VPC is used)
- **ingress and egress rules are added to the security group**
- the default source (and/or destination) of 0.0.0.0/0 is used
- the rules can apply to specific supplied (source and/or destination) addresses

## How to Run the Integration Tests

    $ git clone https://github.com/devops4me/terraform-aws-security-group.git
    $ cd terraform-aws-security-group
    $ terraform init .
    $ terraform apply -auto-approve
    $ terraform destroy -auto-approve

## Integration Test Pre-Conditions

Check before you run the test that

- terraform and git are installed
- you have created an AWS IAM user with VPC permissions
- your [AWS credentials have been installed](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)
- headroom exists for a couple more (temporary) VPCs

