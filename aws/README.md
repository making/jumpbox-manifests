
## Paving AWS

```
cp terraform.tfvars.sample terraform.tfvars
```

Configure your aws environment in `terraform.tfvars`.

```
terraform init terraform
terraform plan -out plan terraform
terraform apply plan
```

## Deploy Jumpbox

```
./deploy-jumpbox.sh
```

```
./ssh-jumpbox.sh
```

## Delete Jumpbox

```
./rm-jumpbox.sh
rm -f jumpbox-creds.yml 
```

### Delete AWS

```
terraform destroy -force terraform
```