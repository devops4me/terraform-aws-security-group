
# Test the AWS VPC Subnets Module

You can unit test the [[terraform-aws-vpc-subnets module]](https://github.com/devops-ip/terraform-aws-vpc-subnets) which **creates VPCs subnets in a round robin** manner.

    $ git clone https://github.com/devops-ip/test-vpc-subnets.git
    $ cd test-vpc-subnets
    $ terraform init .
    $ terraform apply -auto-approve
    $ terraform destroy -auto-approve

## Unit Test Pre-Conditions

Check before you run the test that

- terraform and git are installed
- you have created an AWS IAM user with VPC permissions
- your [[AWS credentials have been installed]](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)
- headroom exists for 10 more VPCs

## Extend the 5 VPC Limit

The default VPC limit is a pithy 5 and we need at least 10 to test all the functionality in this ubiquitous VPC/Subnet creation module.

On receiving your support ticket AWS automatically ups the VPC limit if you request 25 or less.