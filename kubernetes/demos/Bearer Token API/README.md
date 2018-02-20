# We will continue to explore ways of accessing the control plane of our cluster. In the security chapter we will discuss there

# are several authentication methods, one of which is use of a Bearer token We will work with one then deploy a local proxy

# server for application-level access to the Kubernetes API

# to get api url
```
kubectl config view |grep server
```

# Next we need to find the bearer token. This is part of a default token. Look at a list of tokens, first all on the cluster, then just those in the default namespace. There will be a secret for each of the controllers of the cluster.

```
kubectl get secrets --all-namespaces
NAMESPACE     NAME                              TYPE                                  DATA      AGE
default       default-token-cmqbh               kubernetes.io/service-account-token   3         6d
kube-public   default-token-95bwv               kubernetes.io/service-account-token   3         6d
kube-system   default-token-zqvzp               kubernetes.io/service-account-token   3         6d
kube-system   kubernetes-dashboard-key-holder   Opaque                                2         6d
```

# get token

```
export token=$(kubectl describe secret default-token-cmqbh |grep ^token |cut -f7 -d ' ')
```

#  get information from API server
```
curl https://192.168.99.100:8443/apis --header "Authorization: Bearer $token" -k
curl https://192.168.99.100:8443/api/v1 --header "Authorization: Bearer $token" -k
curl https://192.168.99.100:8443/api/v1/namespaces --header "Authorization: Bearer $token" -k

```

# Pods can also make use of included certificates to use the API. The certificates are automatically made available to
a pod under the /var/run/secrets/kubernetes.io/serviceaccount/. We will deploy a simple Pod and view the
resources. If you view the token file you will find it is the same value we put into the $token variable.

```
student@lfs458-node-1a0a:~$ kubectl run -i -t busybox --image=busybox \
--restart=Never
# ls /var/run/secrets/kubernetes.io/serviceaccount/
ca.crt namespace token
/ # exit
```
