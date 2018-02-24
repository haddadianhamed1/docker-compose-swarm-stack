# verifying DNS

# label nodes
```
kubectl get nodes
NAME                                        STATUS    ROLES     AGE       VERSION
gke-helloworld-default-pool-3bed7885-46s4   Ready     <none>    6h        v1.8.7-gke.1
gke-helloworld-default-pool-3bed7885-vc9f   Ready     <none>    6h        v1.8.7-gke.1
gke-helloworld-default-pool-3bed7885-zchp   Ready     <none>    6h        v1.8.7-gke.1

kubectl label nodes gke-helloworld-default-pool-3bed7885-46s4 system=secondOne
node "gke-helloworld-default-pool-3bed7885-46s4" labeled

kubectl label nodes gke-helloworld-default-pool-3bed7885-vc9f system=secondOne
node "gke-helloworld-default-pool-3bed7885-vc9f" labeled
```
# create namespace for our deployment
```
kubectl create namespace accounting
```
# create a deployment and service in the namespace
```
kubectl create -f .
```

# create busy box
```
kubectl create -f busy-box.yaml
```

# create busybox in the same namespace
```
kubectl create -f busy-box-in-namespace.yaml
```


# testing Nodes, Pods, Service DNS resolution from BusyBox in the same namespace
```
kubectl get svc -n accounting
NAME                TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx-one-service   NodePort   10.11.247.144   <none>        80:32162/TCP   34m

kubectl exec -it busybox -n accounting -- cat /etc/resolv.conf
nameserver 10.11.240.10
search accounting.svc.cluster.local svc.cluster.local cluster.local c.hamed-kubernetes-195307.internal. google.internal.
options ndots:5

kubectl exec -it busybox -n accounting -- nslookup nginx-one-service
Server:    10.11.240.10
Address 1: 10.11.240.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-one-service
Address 1: 10.11.247.144 nginx-one-service.accounting.svc.cluster.local
```

# testing Nodes, Pods, Service DNS resolution from BusyBox in different namespace
```
kubectl exec -it busybox -- cat /etc/resolv.conf
nameserver 10.11.240.10
search default.svc.cluster.local svc.cluster.local cluster.local c.hamed-kubernetes-195307.internal. google.internal.
options ndots:5

kubectl exec -it busybox -- nslookup nginx-one-service
Server:    10.11.240.10
Address 1: 10.11.240.10 kube-dns.kube-system.svc.cluster.local

nslookup: can't resolve 'nginx-one-service'
command terminated with exit code 1

kubectl exec -it busybox -- nslookup nginx-one-service.accounting
Server:    10.11.240.10
Address 1: 10.11.240.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-one-service.accounting
Address 1: 10.11.247.144 nginx-one-service.accounting.svc.cluster.local
```

# view cluster information
```
kubectl cluster-info
Kubernetes master is running at https://35.188.247.254
GLBCDefaultBackend is running at https://35.188.247.254/api/v1/namespaces/kube-system/services/default-http-backend/proxy
Heapster is running at https://35.188.247.254/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at https://35.188.247.254/api/v1/namespaces/kube-system/services/kube-dns/proxy
kubernetes-dashboard is running at https://35.188.247.254/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy
```
