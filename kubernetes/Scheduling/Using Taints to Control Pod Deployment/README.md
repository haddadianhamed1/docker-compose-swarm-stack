# Using Taints to Control Pod Deployment
```
Use taints to manage where Pods are deployed or allowed to run.

Master Node begins with a NoSchedule taint.
```

# create nginx deployment
```
kubectl create -f taint.yaml
```

# Now I will taint a Node with PreferNoSchedule
```
preferNoSchedule would not effect the running pods but it would effect newly deployed containers
# taint a node
kubectl taint nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 tainting=value:PreferNoSchedule

# view nodes Taints
kubectl describe nodes | grep Taint
Taints:             tainting=value:PreferNoSchedule
Taints:             <none>
Taints:             <none>

# delete previous deployment
kubectl delete deployment taint-deployment
# create deployment after tainting a node
kubectl create -f taint.yaml

# remove taint
kubectl taint nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 tainting-

# Tainting with NoSchedule causes no new containers creation
kubectl taint nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 tainting=value:NoSchedule

# Tainting with NoExecute
kubectl taint nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 tainting=value:NoExecute
kubectl describe nodes | grep Taint

# all containers should be terminated


# remove taint
kubectl taint nodes gke-hamed-ubuntu-default-pool-52a803d7-05x6 tainting-
# after removing taints we would notice containers are not going back to way it was before tainting the node
pods will be rescheduled
```

# Drain
```
In addition to the ability to taint a node you can also set the status to drain.
kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
gke-hamed-ubuntu-default-pool-52a803d7-05x6   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-dv1l   Ready     <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-swjz   Ready     <none>    2d        v1.8.7-gke.1

# set drain for a Node
kubectl drain gke-hamed-ubuntu-default-pool-52a803d7-05x6 --force --ignore-daemonsets

kubectl get nodes
NAME                                          STATUS                     ROLES     AGE       VERSION
gke-hamed-ubuntu-default-pool-52a803d7-05x6   Ready,SchedulingDisabled   <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-dv1l   Ready                      <none>    2d        v1.8.7-gke.1
gke-hamed-ubuntu-default-pool-52a803d7-swjz   Ready                      <none>    2d        v1.8.7-gke.1

# No New Pod will be scheduled and drains old containers
# to uncordon a Node
kubectl uncordon gke-hamed-ubuntu-default-pool-52a803d7-05x6
```
