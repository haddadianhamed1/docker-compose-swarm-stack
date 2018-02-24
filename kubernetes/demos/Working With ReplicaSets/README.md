# ReplicaSet
```
A Deployment will manage ReplicaSets for you
```

# create first replicasets
```
kubectl create -f rs.yaml
replicaset "rs-one" created

kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
rs-one-6gzlv   1/1       Running   0          39s
rs-one-d4m5s   1/1       Running   0          39s

```

# delete replicaset and not the pods
```
kubectl delete rs/rs-one --cascade=false

# pods are still running
kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
rs-one-6gzlv   1/1       Running   0          2m
rs-one-d4m5s   1/1       Running   0          2m

# if I create the replicaset again
kubectl create -f rs.yaml
# it would take ownership of pods running already
```

# edit a pod
```
kubectl edit pod rs-one-6gzlv
# change label
labels:
  system: IsoalatedPod

kubectl get pods 
NAME           READY     STATUS    RESTARTS   AGE
rs-one-6gzlv   1/1       Running   0          6m
rs-one-d4m5s   1/1       Running   0          6m
rs-one-pzp56   1/1       Running   0          5s

```
