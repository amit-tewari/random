This terraform code is to create a minimal on demand debian based minimal system that can be used by new learners with ease.


How to use
===

* provide aws credential in `[default]` block,
* update the ssh public key
```
$ terraform validate
$ terraform plan
$ terraform apply
```
use the Elastic IP returned and SSH key specified

once hands on are completed, VM can be deleted, to stop incurring bill, by running
```
$ terraform destroy
```
*Note* all content will be deleted with VM
