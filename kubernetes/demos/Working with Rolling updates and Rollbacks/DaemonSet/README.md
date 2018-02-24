# Rolling updates and Rollbacks

# create a daemonset
```
kubectl create -f ds.yaml
kubectl get ds
NAME      DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
ds-one    1         1         1         1            1           <none>          1h
```

# check updateStrategy setting for the DaemonSet
```
kubectl get ds/ds-one -o yaml | grep -A 1 Strategy
 updateStrategy:
   type: OnDelete
```

# update DaemonSet to use newer image
```
option 1 ) edit DaemonSet
kubectl edit ds ds-one
spec:
  containers:
  - image: nginx:1.7.9
    imagePullPolicy: IfNotPresent
    name: nginx
    ports:

option2 ) use set
kubectl set image ds ds-one nginx=nginx:1.8.1-alpine
```

# check current pod
```
kubectl describe pod ds-one-kf9k6 | grep Image
    Image:          nginx:1.7.9
```

# check the rollouts we should see a new one
```
kubectl rollout history ds/ds-one
daemonsets "ds-one"
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

kubectl rollout history ds/ds-one --revision=1
daemonsets "ds-one" with revision #1
Pod Template:
 Labels:	system=DaemonSetone
 Containers:
  nginx:
   Image:	nginx:1.7.9
   Port:	80/TCP
   Environment:	<none>
   Mounts:	<none>
 Volumes:	<none>

kubectl rollout history ds/ds-one --revision=2
daemonsets "ds-one" with revision #2
Pod Template:
 Labels:	system=DaemonSetone
 Containers:
  nginx:
   Image:	nginx:1.8.1-alpine
   Port:	80/TCP
   Environment:	<none>
   Mounts:	<none>
 Volumes:	<none>

```


# rollout the daemonset by deleting pod
```
kubectl delete pod ds-one-kf9k6
# check new pod
kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
ds-one-7wgdj   1/1       Running   0          0s

kubectl describe pod ds-one-7wgdj | grep Image
    Image:          nginx:1.8.1-alpine
```

# revert back the rollout
```
kubectl rollout undo ds/ds-one --to-revision=1
# delete current pod
kubectl delete pod ds-one-7wgdj

kubectl describe pod ds-one-bwv2c | grep Image
   Image:          nginx:1.7.9
```

# lets change the rollout policy
```
kubectl get ds/ds-one -o yaml > ds2.yaml
# change the name and type in the new file and remove status lines

kubectl create -f ds2.yaml

kubectl get ds/ds-two -o yaml | grep -A 3 Strategy
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
```

# check the Pod
```
kubectl describe po/ds-two-lh9zn | grep Image
    Image:          nginx:1.7.9

# update image
kubectl set image ds ds-two nginx=nginx:1.8.1-alpine

kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
ds-two-t8jxw   1/1       Running   0          2s
```
