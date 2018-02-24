# Services
Services (also called microservices) are objects which declare a policy to access a logical set of Pods. They are typically
assigned with labels to allow persistent access to a resource, when front or back end containers are terminated and replaced.
Native applications can use the Endpoints API for access. Non-native applications can use a Virtual IP-based bridge to
access back end pods. ServiceTypes Type could be:
• ClusterIP default - exposes on a cluster-internal IP. Only reachable within cluster
• NodePort Exposes node IP at a static port. A ClusterIP is also automatically created.
• LoadBalancer Exposes service externally using cloud providers load balancer. NodePort and ClusterIP automatically
created.
• ExternalName Maps service to contents of externalName using a CNAME record.
We use services as part of decoupling such that any agent or object can be replaced without interruption to access from client to back end application.

# the kubectl proxy command creates a local service to access a clusterIP. This can be useful for troubelshooting or development work.


```
The kube-proxy running on a cluster nodes watches the API server service resources. It presents a type of virtual IP address for service other than ExternalName
in V1.0 services ran in userspace mode as TCP/UDP over IP or layer4
in V1.1 realease, the iptables proxy was added and became the default mode starting with v1.2

Readiness Probe is used to ensure all containers are functional prior to connection.This mode alows for up to approximately 5000 nodes

Another mode beginning in v1.9 is ipvs. while in beta and expected to change, it works in the kernel space for greater speed, and allows for a configurable load-balancing algorithm, such as round-robing, shortest expected delay, least connection and several others. This mode assumes IPVS kernel modules are installed and running prior to kube-proxy

the kube-proxy mode is configured via a flag sent during initialization, such as mode=iptables and cloud also be IPVS or userspace
```

# Local proxy
```
when developing an application or service one quick way to check your service is to run a local proxy with kubectl. It will capture the shell unless you place it in the background. you can make calls to kubernetes API on localhost and also reach the ClusterIP services on their API url.

kubectl proxy
Starting to serve on 127.0.0.1:8001

for example to access ghost service using the local proxy
http://localhost:8001/api/v1/namespaces/default/services/ghost:<port_name>
```

# in thie folder we have
1) Deployments # includes example of LoadBalancer and NodePort on GKE
