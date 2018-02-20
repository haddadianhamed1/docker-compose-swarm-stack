# kubeadm is used to bootstrap a cluster quickly

```
Three steps to create a cluster
kubeadm init
kueadm join --token <token> <head node IP address>
```
# create weave network
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```


# other tools
```
kubespray is now in the kubernetes incubator. It is an advanced Ansible playbook which allows you to setup a Kubernetes cluster on various operating systems and use different network providers

kops lets you create a Kubernetes cluster on AWS via a single command line

kube-aws is a command line tool that makes use of the AWS cloud Formation to provision a Kubernetes cluster on AWS

kubicorn is a golang library that can be used to provision and manage kubernetes clusters. It is currently a work in progress and should not be used in production
```

# install link
```
https://github.com/kelseyhightower/kubernetes-the-hard-way
```
