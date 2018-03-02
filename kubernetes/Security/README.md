# Security

# Kube-apiserver
 ```
Step1) authentication
kube-apiserver goes through a 3-step process for each API call. The first one is authentication. This can be done with an X509 certificate, a token or even a webhook to an LDAP server.

Step2) Authorization
Authorization is handled by RBAC (Role Based Access Control)

step3) admissions controllers there are 8 or 9 by default.
The first admission controller is called the initializer, which allows us to dynamically change the API call iteself.
you can do anything with initializer controller to the API call before its passed to the kubelet to actually run on a node.

Admission controller lets you look at and possibly modify the requests that are coming in, and do a final deny or accept on those requests.
 ```


# Pods Security
```
securing pods more tightly using security contexts and pod security policies, which are full-fledged API objects in Kubernetes.

```

# Network Policy
```
By default we tend not to turn on network policies, which let any traffic flow through all of our pods, in all the different namespaces. Using network policies, we can actually define Ingress rules so that we can restrict the Ingress Traffic between the different namespaces. The network tool in use, such as Flannel or Calico will determine if a network policy can be implemented. As kubernetes becomes more mature, this will become a strongly suggested configuration.
```
