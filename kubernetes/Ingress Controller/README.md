# Ingress Controller
```
Allows the same sort of activity but is more efficient
Instead of individual Services for each of the pods, we can setup a controller that handles all of the traffic
Currently there are two supported controllers, one for Nginx, the other one for GCE

HA proxy is being developed, but is not yet considered a supported and stable resource.

difference between services and Ingress is efficiency. Instead of using lots of services, such as LoadBalancer, you can route traffic based on the request host or path. This allows for centralization of many services to a single point.

An Ingress Controller is different than most controllers, as it does not run as part of the kube-controller-manager binary. you can deploy multiple controllers, each with unique configuration.

Two Supported Ingress controllers, GCE and Nginx. HAProxy and Traefix.io are also in common use.

you can leave a service as a CLusterIP type and define how the traffic gets routed to that internal service using an Ingress Rule.

Ingress Controller is a daemon running in a Pod which watches the /ingress endpoint on the API server which is found under the extensions/v1beta1 group for new objects.

when a new endpoint is created, the daemon uses the configured set of rules to allow inbound connection to a service, most often HTTP traffic.


# Deploying ingress-nginx
https://github.com/kubernetes/ingress-nginx/tree/master/deploy

Customization can be done via a ConfigMap, Annotations, or for detailed configuration a custome template:
# Easy Integration with RBAC
# Uses the annotation kuberntes.io/ingress.class: "nginx"
# L7 traffic requires the proxy-real-ip-cidr setting
# Bypass kube-proxy to allow session affinity
# Does not use conntrack entries for iptables DNAT
# TLS requires the host field to be defined
```

# GLBC Google LoadBalancer Controller
```
GLBC controller and started first. Also you must create a ReplicationController with a single replica, three services for the application Pod, and an Ingress with two hostnames and three endpoints for each service. The backend is a group of virtulal machine instances, Instance Group/

Each path for traffic uses a group of like objects referred to as a pool. Each pool regularly checks the next hop up to ensure connectivity.

Multi-pool path:
Global Forwaring Rule -> Target HTTP Proxy -> URL map -> Backend Service -> Instance Group

TLS ingress only supports port 443 and assumes TLS termination. It does not support SNI, only using the first certificate. TLS Secret must contain keys named tls.cert and tls.key
```


# create nginx deployments
```
kubectl run nginx --image=nginx --port=80
```

# Expose your nginx deployment as a service internally
```
kubectl expose deployment nginx --target-port=80  --type=NodePort

kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx        NodePort    10.11.253.107   <none>        80:31293/TCP   1m
```

# Create an Ingress Resource
```
kubectl create -f basic-ingress.yaml
```

# get the external IP of LoadBalancer
```
kubectl get ingress
NAME            HOSTS     ADDRESS         PORTS     AGE
basic-ingress   *         35.190.16.128   80        1m
```

# Configuring a Static IP Address
```
Option 1: Convert existing ephemeral IP address to static IP address

If you already have an Ingress deployed, you can convert the existing ephemeral IP address of your application to a reserved static IP address without changing the external IP address by visiting the External IP addresses section on GCP Console.

Option 2: Reserve a new static IP address

Reserve a static external IP address named nginx-static-ip by running:

gcloud compute addresses create nginx-static-ip --global
```

# replace the basic-ingress.yaml manifest with new manifest
```
kubectl apply -f basic-ingress-staticip.yaml
```


## Serving multiple applications on a Load Balancer

# create another web server Deployment
```
kubectl run echoserver --image=gcr.io/google_containers/echoserver:1.4 --port=8080
kubectl expose deployment echoserver --target-port=8080 --type=NodePort

kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
echoserver   NodePort    10.11.245.145   <none>        8080:31224/TCP   4s
nginx        NodePort    10.11.253.107   <none>        80:31293/TCP     16m
```

# create Ingress for multiple sites
```
kubectl create -f basic-ingress-multiple-site.yaml

kubectl get ing
NAME             HOSTS     ADDRESS         PORTS     AGE
fanout-ingress   *         35.190.69.33    80        20m

visit http://<IP_ADDRESS>/ to see the welcome page of the nginx Service, and visit http://<IP_ADDRESS>/echo to see the response from the echoserver Service.
```

# create Ingress for Hostname
```
foo.bar.com --|                 |-> foo.bar.com s1:80
              | 178.91.123.132  |
bar.foo.com --|                 |-> bar.foo.com s2:80

kubectl create -f basic-ingress-hostname.yaml

```

# create TLS endpoints
```
# Create SSL certificate
create a self-signed key and certificate pair with OpenSSL

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/nginx-selfsigned.key -out /tmp/nginx-selfsigned.crt

# create Kubernetes Secret Note: we need to have tls.key and tls.cert values for Ingress
kubectl create secret tls tls-secret --key /tmp/nginx-selfsigned.key --cert /tmp/nginx-selfsigned.crt

# check Secrets
get secrets tls-secret -o yaml

# get Ingress
kubectl get ing
NAME                HOSTS     ADDRESS          PORTS     AGE
basic-ingress-tls   *         35.227.238.166   80, 443   5m

# we can browse to https://address and http://address
```
