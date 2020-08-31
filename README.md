# Terraform Karlesnine mini lab for Salt on Centos8

Small terraform project to quickly create a lab of three servers on AWS with the default VPC.
Based on [k9-terraform-lab - ubuntu](https://github.com/karlesnine/k9-terraform-lab) with adaptation for Centos 8

## Requirement
- Terraform v0.12.24
  - provider.aws v2.65.0
  - provider.http v1.2.0
  - provider.null v2.1.2
  - provider.template v2.1.2
- aws-cli/1.18.47 

## Use it
- clone this
- Modify `variable.tf` with your own  information
- Use [Centos 8 AMI ](https://wiki.centos.org/Cloud/AWS#Finding_AMI_ids)
- Configure localy aws cli
- Check auto configuration script in ./common/s3-files to adapte (Some variable hardcoded)

## Salt Installation
- Check `SetSalt.sh` in `/usr/local/bin` to install salt. (Some variable hardcoded)
