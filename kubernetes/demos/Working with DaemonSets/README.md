# DaemonSet
```
The DaemonSet ensures that as nodes are added to a cluster Pods will be created on them
```

# create DaemonSet
```
kubectl create -f ds.yaml

kubectl get pod
NAME           READY     STATUS    RESTARTS   AGE
ds-one-kf9k6   1/1       Running   0          26s
```
