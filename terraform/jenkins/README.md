# Create on demand Jenkins node

with data persisting in EBS volume

## installation

  * download from https://www.terraform.io/downloads.html
  * extract in `path` somewhere

## initialize

```
$ terraform init
```

## create instance, ebs volume and attachment

edit jenkins.tfvars and set `enable_jenkins_instance` to 
  * `true` to create the instance
  * `false` to delete the instance, but retain the volume

```
$ terraform validate -var-file="jenkins.tfvars"
$ terraform plan -var-file="jenkins.tfvars"
$ terraform apply -var-file="jenkins.tfvars"
```


## More terraform help ?
https://learn.hashicorp.com/terraform/getting-started/install.html
