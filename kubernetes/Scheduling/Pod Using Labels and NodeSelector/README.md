# Assign Pods Using Labels
```
While allowing the system to distribute Pods on your behalf sometimes you may want to determine which nodes a Pod will use.
I will use labels to schedule Pods to a particular node. Then we will explore taints to have more flexible deployment in a large environment.
```

# view nodes
```
kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
gke-hamed-ubuntu-default-pool-52a803d7-05x6   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-dv1l   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-swjz   Ready     <none>    2d        v1.8.7-gke.1
```

# view labels and taints
```
kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
gke-hamed-ubuntu-default-pool-52a803d7-05x6   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-dv1l   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-swjz   Ready     <none>    2d        v1.8.7-gke.1
hamedh-mv-ltmp-x:delete-docker-compose-swarm-stack hamedh$ kubectl describe nodes |grep -i label
Labels:             beta.kubernetes.io/arch=amd64
Labels:             beta.kubernetes.io/arch=amd64
Labels:             beta.kubernetes.io/arch=amd64
hamedh-mv-ltmp-x:delete-docker-compose-swarm-stack hamedh$ kubectl describe nodes |grep -i taints
Taints:             <none>
Taints:             <none>
Taints:             <none>
```

# label a node
```
kubectl label nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 status=vip

kubectl get nodes --show-labels
NAME                                          STATUS    ROLES     AGE       VERSION        LABELS
gke-hamed-ubuntu-default-pool-52a803d7-05x6   Ready     <none>    2d        v1.8.7-gke.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/fluentd-ds-ready=true,beta.kubernetes.io/instance-type=n1-standard-1,beta.kubernetes.io/os=linux,cloud.google.com/gke-nodepool=default-pool,failure-domain.beta.kubernetes.io/region=us-east4,failure-domain.beta.kubernetes.io/zone=us-east4-a,kubernetes.io/hostname=gke-hamed-ubuntu-default-pool-52a803d7-05x6,status=vip,system=secondOne
```

# create pods with NodeSelector
```
kubect create -f vip.yaml
```
