# Kops create new Cluster
```
export NAME=test.cherinehaddadian.com
export KOPS_STATE_STORE=s3://kops-hamed-s3
 kops create cluster $NAME \
    --zones "us-east-2a,us-east-2b,us-east-2c" \
    --master-zones "us-east-2a,us-east-2b,us-east-2c" \
    --networking weave \
    --topology private \
    --bastion \
    --node-count 3 \
    --node-size m4.xlarge \
    --kubernetes-version v1.6.6 \
    --master-size m4.large \
    --vpc vpc-6335dd1a \
    --dry-run \
    -o yaml > $NAME.yaml

# multiAZ KOPS
export NAME=test1.cherinehaddadian.com
export KOPS_STATE_STORE=s3://kops-hamed-s3
 kops create cluster $NAME \
    --zones "us-east-2a,us-east-2b,us-east-2c" \
    --master-zones "us-east-2a,us-east-2b,us-east-2c" \
    --networking weave \
    --topology private \
    --bastion \
    --node-count 3 \
    --node-size m4.xlarge \
    --kubernetes-version v1.6.6 \
    --master-size m4.large \
    --vpc vpc-6335dd1a \
    --dry-run \
    -o yaml > kops-az.yaml


AWS_PROFILE=personal kops  create cluster --name=test.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --dry-run -o yaml > kop-create.yaml   


# Kops HA
AWS_PROFILE=personal kops create cluster --name=testha.cherinehaddadian.com --state=s3://kops-terraform-s3 --zones=us-west-2a,us-west-2b,us-west-2c --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --dry-run -o yaml > kops-ha-create.yaml
```

# change value of max size so we can use autoscaling
```
maxSize: 5
```
# deploy
```
AWS_PROFILE=personal kops create -f kops-ha-create.yaml  --state=s3://kops-terraform-s3
AWS_PROFILE=personal kops create secret --name testha.cherinehaddadian.com sshpublickey admin -i ~/.ssh/id_rsa_kub.pub --state=s3://kops-terraform-s3

# to update
AWS_PROFILE=personal kops replace -f kops-ha-create.yaml  --state=s3://kops-terraform-s3

```

#  terraform
```
AWS_PROFILE=personal kops update cluster \
  --name=testha.cherinehaddadian.com \
  --state=s3://kops-terraform-s3 \
  --out=. \
  --target=terraform
```

# to apply
```
AWS_PROFILE=personal terraform init
AWS_PROFILE=personal terraform plan
AWS_PROFILE=personal terraform apply
```

# to Add more InstanceGroups
```
AWS_PROFILE=personal kops replace -f kops-ha-create.yaml  --state=s3://kops-terraform-s3 --force
AWS_PROFILE=personal kops update cluster   --name=testha.cherinehaddadian.com   --state=s3://kops-terraform-s3   --out=.   --target=terraform
AWS_PROFILE=personal terraform plan
AWS_PROFILE=personal terraform apply
```


# to tag auto scaling groups
```
spec:
  cloudLabels:
    billing: infra
```
# list cluster
```
AWS_PROFILE=personal kops get cluster --state=s3://kops-terraform-s3
```

# delete cluster
```
AWS_PROFILE=personal kops delete cluster testha.cherinehaddadian.com --state=s3://kops-terraform-s3
AWS_PROFILE=personal kops delete cluster testha.cherinehaddadian.com --state=s3://kops-terraform-s3 --yes

or:
AWS_PROFILE=personal terraform destroy
```
