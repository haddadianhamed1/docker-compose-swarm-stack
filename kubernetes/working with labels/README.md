# labels

# use labels to view and delete pods
```
kubectl get pods -l app=nginx -n accounting

kubectl delete pods -l app=nginx -n accounting
```

# deployments
```
kubectl get deploy -n accounting --show-labels
NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
nginx-one   4         4         4            4           46m       system=secondary

kubectl delete deploy \
-l system=secondary -n accounting
```

# Nodes Labels
```
# view nodes
kubectl get nodes

# label a node
kubectl label node gke-hamed-ubuntu-default-pool-52a803d7-05x6 system=secondOne

# Remove a label
kubectl label node gke-hamed-ubuntu-default-pool-52a803d7-05x6 system-
```
