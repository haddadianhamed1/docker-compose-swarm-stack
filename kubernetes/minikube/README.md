# install minikube
```
https://github.com/kubernetes/minikube/releases
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

# next install kubectl
brew install kubernetes-cli

```

# delete older minikube
```
minikube delete
```
# start minikube
```
minikube start
```
# ssh to minikube
```
minikube ssh
```
# check kubectl cluster
```
kubectl config get-contexts
kubectl config set current-context minikube
```

# to view nodes for each config
```
kubectl get node
```

# create cluster
```
kubectl create -f hamed.yaml
```

# get endpoint
```
minikube service list

| default     | helloworld-service   | http://192.168.99.100:31001 |

```

# code testing
```
http://192.168.99.100:31001
http://192.168.99.100:31001/inc
```

# minikube dashboard

```
minikube dashboard
```
