# Using GKE create neing service

# view context
```
kubectl config get-contexts
```

# set context to GKE
```
kubectl config set current-context gke_hamed-kubernetes-195307_us-east4-a_helloworld
```

# get nodes
```
kubectl get nodes
NAME                                        STATUS    ROLES     AGE       VERSION
gke-helloworld-default-pool-9dd88111-frlt   Ready     <none>    5d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-n5rk   Ready     <none>    5d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-rb4t   Ready     <none>    5d        v1.7.12-gke.1
```
# create namespace accounting
```
kubectl create namespace accounting
```

# Label Node
```
kubectl get nodes
NAME                                        STATUS    ROLES     AGE       VERSION
gke-helloworld-default-pool-9dd88111-frlt   Ready     <none>    5d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-n5rk   Ready     <none>    5d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-rb4t   Ready     <none>    5d        v1.7.12-gke.1

kubectl label nodes gke-helloworld-default-pool-9dd88111-rb4t system=secondOne
node "gke-helloworld-default-pool-9dd88111-rb4t" labeled

kubectl label nodes gke-helloworld-default-pool-9dd88111-n5rk system=secondOne
node "gke-helloworld-default-pool-9dd88111-n5rk" labeled

kubectl get nodes --show-labels
```

# deployment
```
kubectl create -f nginx-one.yaml
```

# check deployments and pods
```
kubectl get pods -o wide -n accounting
NAME                         READY     STATUS    RESTARTS   AGE       IP          NODE
nginx-one-2916746321-6p87c   1/1       Running   0          12m       10.4.0.13   
nginx-one-2916746321-csjkh   1/1       Running   0          12m       10.4.2.9    

kubectl get pods -n accounting
NAME                         READY     STATUS    RESTARTS   AGE
nginx-one-2916746321-6p87c   1/1       Running   0          2m
nginx-one-2916746321-csjkh   1/1       Running   0          2m
```

# expose the service using LoadBalancer
```
kubectl expose deployment nginx-one --type=LoadBalancer --name=my-nginx -n accounting
kubectl get svc -n accounting
NAME       TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
my-nginx   LoadBalancer   10.7.243.145   35.194.70.203   80:32042/TCP   34s

curl 35.194.70.203:80
```

# expose the Service Via NodePort
```
kubectl expose deployment nginx-one --type=NodePort --name=my-nginx -n accounting

or via service defintion
kubect create -f nginx-one-service -n accounting

kubectl get svc -n accounting
NAME                TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
nginx-one-service   NodePort   10.7.246.243   <none>        80:30919/TCP   6s

curl anynode:30919
```
