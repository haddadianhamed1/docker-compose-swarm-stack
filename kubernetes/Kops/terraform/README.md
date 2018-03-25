# Kops with terraform
# step 1) create s3 bucket for backend configuration
```
cd s3-backend/
terraform init
AWS_PROFILE=personal terraform apply
```
# step 2) Terraform State file
```
You could keep your Terraform state locally, but we strongly recommend saving it on S3 with versioning turned on on that bucket. Configure a remote S3 store with a setting like below:

# with terraform command or file
Terraform remote config -backend=s3 -backend-config=“bucket=terraform-state-f29c3” -backend-config=“key=terraform.tfstate” -backend-config=“region=eu-west-1”

AWS_PROFILE=personal terraform init
```

# Step 3) create terraform for kops using kops
```
Kops support terraform output

kops create cluster \
  --name=kubernetes.mydomain.com \
  --state=s3://mycompany.kubernetes \
  --dns-zone=kubernetes.mydomain.com \
  [... your other options ...]
  --out=. \
  --target=terraform

AWS_PROFILE=personal kops create cluster --name=testha.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a,us-west-2b,us-west-2c --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --out=. -o --target=terraform
```
