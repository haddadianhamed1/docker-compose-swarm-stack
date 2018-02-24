# DNS
The DNS resolution is provided as a kubernetes add-on in clusters. Clusters built with kubeadm, GKE and others deploy this add-on by default.

```
kube-dns Pod contains three containers.

A)The kubedns container maintains in-memory lookup structures and monitors the API server.
B)dnsmasq improves performance by DNS caching
C) healthz checks the health of other two containers and provides a single health-check endpoint to the cluster

As services are created, they get automatically registered in DNS. The DNS lookup will further direct traffic to one of the matching pods via the ClusterIP of the service and its matching endpoints.

the DNS server and DNS domain internal to the cluster are defined as startup options of the kubelet running on each node of the cluster by editing the --resolv-conf flag, an alternate DNS resolution can be configured.

for a large cluster, you may need to configure the autoscaler which uses the container image k8s.gcr.io/cluster-proportional-autoscaler-amd64 which allows scaling more DNS server baed on cores or nodes in the cluster

ConfigMap for kube-dns, cluster administrators can specify custom stub domain and upstream servers.
```
