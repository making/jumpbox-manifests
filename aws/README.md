
```
cp terraform.tfvars.sample terraform.tfvars
```

Configure your aws environment in `terraform.tfvars`.

```
terraform init terraform
terraform plan -out plan terraform
terraform apply plan
```


```
./deploy-jumpbox.sh
```

```
./ssh-jumpbox.sh
```

```
terraform destroy -force terraform
```