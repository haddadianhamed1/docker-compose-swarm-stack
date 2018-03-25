# Kops
# step 1 create Domain in Route53

# step 2 generate a new ssh key
```
ssh-keygen -f ~/.ssh/id_rsa_kub
```
# step 3 create a bucket
```
kops-hamed-s3
```

# step 4 install kops
```
brew update && brew install kops
```

#  kops create cluster \
  --name=kubernetes.mydomain.com \
  --state=s3://mycompany.kubernetes \
  --dns-zone=kubernetes.mydomain.com \
  [... your other options ...]
  --out=. \
  --target=terraform
# create kops cluster
```
AWS_PROFILE=personal kops  create cluster --name=test.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub

AWS_PROFILE=personal kops update cluster test.cherinehaddadian.com --state=s3://kops-hamed-s3 --yes
```
# create kops cluster with terraform
```
AWS_PROFILE=personal kops  create cluster --name=test.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --out=. --target=terraform

# this will create kubernetes.tf file and data directory which includes all the iam roles required.
```

# initialize terraform
```
terraform init
AWS_PROFILE=personal terraform plan
AWS_PROFILE=personal terraform apply
```

# to edit the cluster
```
kops edit cluster \
  --name=kubernetes.mydomain.com \
  --state=s3://mycompany.kubernetes

kops update cluster \
  --name=kubernetes.mydomain.com \
  --state=s3://mycompany.kubernetes \
  --out=. \
  --target=terraform
AWS_PROFILE=personal terraform plan
AWS_PROFILE=personal terraform apply

# graph terraform
AWS_PROFILE=personal terraform graph | dot -Tpng > graph.png
```

# work with our cluster
```
kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
ip-172-20-33-249.us-west-2.compute.internal   Ready     node      21m       v1.8.6
ip-172-20-53-174.us-west-2.compute.internal   Ready     node      21m       v1.8.6
ip-172-20-63-220.us-west-2.compute.internal   Ready     master    23m       v1.8.6
```
# create a small deployment
```

```

# delete cluster
```
AWS_PROFILE=personal kops delete cluster test.cherinehaddadian.com --state=s3://kops-hamed-s3 --yes
AWS_PROFILE=personal kops delete cluster test.cherinehaddadian.com --state=s3://kops-hamed-s3
```

# list clusters
```
AWS_PROFILE=personal kops get clusters --state=s3://kops-hamed-s3
NAME				CLOUD	ZONES
test.cherinehaddadian.com	aws	us-west-2a
```
# autoscaling
https://renzedevries.wordpress.com/2017/01/10/autoscaling-your-kubernetes-cluster-on-aws/
https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws#1-asg-setup-min-1-max-10-asg-name-k8s-worker-asg-1
https://github.com/kubernetes/kops/blob/master/docs/instance_groups.md
https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md
# check max for autoscaling
```
AWS_PROFILE=personal kops edit ig nodes --state=s3://kops-hamed-s3
```





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


AWS_PROFILE=personal kops  create cluster --name=test.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --out=. --target=terraform


# Kops HA
AWS_PROFILE=personal kops create cluster --name=testha.cherinehaddadian.com --state=s3://kops-hamed-s3 --zones=us-west-2a,us-west-2b,us-west-2c --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=cherinehaddadian.com --ssh-public-key=~/.ssh/id_rsa_kub.pub --dry-run -o yaml > kops-ha-create.yaml
```
