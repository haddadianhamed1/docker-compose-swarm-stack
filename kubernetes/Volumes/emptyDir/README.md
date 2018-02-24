# emptyDir
```
emptyDir works only for pods or cotainers inside the same pod
emptyDir is an empty directory that gets erased when the Pod dies
once the pod is destroyed the kubelet will delete the directory
```

# create pod
```
kubectl create -f emptyDir-volume.yaml
```

# view pods
```
kubectl get pods
NAME      READY     STATUS    RESTARTS   AGE
busybox   2/2       Running   0          3h
```

# create a directory on the first containers
```
kubectl exec -it busybox -c box -- touch /box/foobar
```

# check the volume on second container and the file is there
```
kubectl exec -it busybox -c busy -- ls -l /busy
total 0
-rw-r--r--    1 root     root             0 Feb 20 03:29 foobar
```
