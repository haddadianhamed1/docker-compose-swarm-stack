```
Using the Kubernetes API, kubectl makes API calls for you. With the appropriate TLS keys you could run curl as well use a
golang client. Calls to the kube-apiserver get or set a PodSpec, or desired state. If the request represents a new state the
Kubernetes Control Plane will update the cluster until the current state matches the specified state. Some end states may
require multiple requests. For example, to delete a ReplicaSet, you would first set the number of replicas to zero, then delete
the ReplicaSet.
An API request must pass information as JSON. kubectl converts .yaml to JSON when making an API request on your
behalf. The API request has many settings, but must include apiVersion, kind and metadata, and spec settings to declare
what kind of container to deploy. The spec fields depend on the object being created
```

# Configure TLS Access
We need three certificates

```
export client=$(grep client-cert ~/.kube/config |cut -d" " -f 6)  or for minikube ~/.minikube/client.crt
export key=$(grep client-key-data ~/.kube/config |cut -d " " -f 6) or for minikube ~/.minikube/client.key
export auth=$(grep certificate-authority-data ~/.kube/config |cut -d " " -f 6) or for minikube ~/.minikube/ca.crt
```

# write the values to a file
```
echo $client | base64 -d - > ./client.pem
echo $key | base64 -d - > ./client-key.pem
echo $auth | base64 -d - > ./ca.pem
```

# to get api url
```
kubectl config view |grep server
```
# test
```
curl --cert /Users/hamedh/.minikube/client.crt --key ~/.minikube/client.key --cacert ~/.minikube/ca.crt https://192.168.99.100:8443/api/v1
```
# json file to create a new pod
```
curl --cert /Users/hamedh/.minikube/client.crt --key ~/.minikube/client.key --cacert ~/.minikube/ca.crt https://192.168.99.100:8443/api/v1/namespaces/default/pods -XPOST -H 'Content-Type: application/json' -d@curlpod.json
```

# get pods
```
kubectl get pods
NAME      READY     STATUS    RESTARTS   AGE
curlpod   1/1       Running   0          17s
```
