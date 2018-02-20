# Secrets
```
pods can access data using Volumes but there are types of data that need to be handled with care

By default the secrets are not
```

# Risks
```
Risks
# In the API server secret data is stored as plaintext in etcd; therefore:
  Administrators should limit access to etcd to admin users
  Secret data in the API server is at rest on the disk that etcd uses; admins may want to wipe/shred disks used by
  etcd when no longer in use

# If you configure the secret through a manifest (JSON or YAML) file which has the secret data encoded as base64, sharing this file or checking it in to a source repository means the secret is compromised. Base64 encoding is not an encryption method and is considered the same as plain text.

# A user who can create a pod that uses a secret can also see the value of that secret. Even if apiserver policy does not allow that user to read the secret object, the user could run a pod which exposes the secret.

# If multiple replicas of etcd are run, then the secrets will be shared between them. By default, etcd does not secure peer-to-peer communication with SSL/TLS, though this can be configured.

# Currently, anyone with root on any node can read any secret from the apiserver, by impersonating the kubelet. It is a planned feature to only send secrets to nodes that actually require them, to restrict the impact of a root exploit on a single node.
```

# Best Practices
```
# When deploying applications that interact with the secrets API, access should be limited using authorization policies such as RBAC.

```

# Creating a Secret Using kubectl create secret
```
echo -n "admin" > /tmp/username.txt
echo -n "1f2d1e2e67df" > /tmp/password.txt
kubectl create secret generic db-user-pass --from-file=/tmp/username.txt --from-file=/tmp/password.txt

kubectl get secrets
NAME                  TYPE                                  DATA      AGE
db-user-pass          Opaque                                2         4s

```

# Decode Secrets
```
kubectl get secret db-user-pass -o yaml
apiVersion: v1
data:
  password.txt: MWYyZDFlMmU2N2Rm
  username.txt: YWRtaW4=
kind: Secret
metadata:
  creationTimestamp: 2018-02-20T04:53:10Z
  name: db-user-pass
  namespace: default
  resourceVersion: "64739"
  selfLink: /api/v1/namespaces/default/secrets/db-user-pass
  uid: f334f7d2-15f9-11e8-9296-0800271da27f
type: Opaque

echo "YWRtaW4=" | base64 --decode
admin
```

# Creating a secrets Manually
```
kubectl create secret generic mysql --from-literal=password=root

kubectl get secret mysql -o yaml
apiVersion: v1
data:
  password: cm9vdA==
kind: Secret
metadata:
  creationTimestamp: 2018-02-20T05:01:20Z
  name: mysql
  namespace: default
  resourceVersion: "65051"
  selfLink: /api/v1/namespaces/default/secrets/mysql
  uid: 17339256-15fb-11e8-9296-0800271da27f
type: Opaque
```

# Creating a Secret Manually
```
$ echo -n "admin" | base64
YWRtaW4=
$ echo -n "1f2d1e2e67df" | base64
MWYyZDFlMmU2N2Rm

# Now write a secret object that looks like this:

apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: YWRtaW4=
  password: MWYyZDFlMmU2N2Rm
kubectl create -f ./secret.yaml
```

# Using Secret via Environment Variables
```
spec:
  name: mysql
  containers:
  - image: mysql:5.5
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
            name: mysql
            key: password
```

# Using Secrets via Volumes
```
spec:
  name: busy
  containers:
  - image: busybox
    command:
      - sleep
      - "3600"
    volumeMounts:
    - mountPath: /mysqlpassword
      name: mysql
    volumes:
    - name: mysql
      secret:
        secret:
          secretName: mysql

# to view the password
kubect exec -it busybox -- cat /mysqlpassword/password
root
```
