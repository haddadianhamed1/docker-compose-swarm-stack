# ConfigMaps
```
most use cases are configuration files
lets say we have a file that contains configuration called config.js
configmap  is basically a set of key-value pairs. This data can be made available so that a Pod
can read the data as environment variables or configuration data
```

# lets create a config map from file in Primary Directory and value we pass
```
kubectl create configmap colors --from-literal=text=black --from-file=./favorite --from-file=./primary/

kubectl get configmap colors
NAME      DATA      AGE
colors    6         32s

kubectl get configmap colors -o yaml
apiVersion: v1
data:
black: |
  k
  known as key
cyan: |
  c
favorite: |
  blue
magenta: |
  m
text: black
yellow: |
  y
kind: ConfigMap
metadata:
creationTimestamp: 2018-02-22T22:27:42Z
name: colors
namespace: default
resourceVersion: "67036"
selfLink: /api/v1/namespaces/default/configmaps/colors
uid: 98eede4b-181f-11e8-9357-42010a960ff3
```

# create configmap
```
kubectl create configmap foobar --from-file=config.js
kubectl get configmap
kubectl get configmap foobar -o yaml
```

# first configmap as a variable
```
kubectl create -f variable-configmap.yaml

kubectl exec -it shell-demo -- /bin/bash -c 'echo $ilike'
blue
```
# ConfigMap as Environment Variables
```
kubectl create -f environemntVariable-configmap.yaml

kubectl exec -it shell-demo -- /bin/bash -c 'env'
...
black=k
known as key
favorite=blue
yellow=y
magenta=m
cyan=c
...
```

# configMap creation from a file
```
kubectl create -f car-map.yaml


kubectl get configmap
NAME       DATA      AGE
colors     6         21m
fast-car   3         4s

kubectl get configmap fast-car -o yaml
apiVersion: v1
data:
 car.make: Ford
 car.model: Mustang
 car.trim: Shelby
kind: ConfigMap
metadata:
 creationTimestamp: 2018-02-22T22:49:23Z
 name: fast-car
 namespace: default
 resourceVersion: "68802"
 selfLink: /api/v1/namespaces/default/configmaps/fast-car
 uid: a0599669-1822-11e8-9357-42010a960ff3
```

# Configmap as Voluem
```
kubectl create -f Volume-configmap.yaml

kubectl exec -it shell-demo -- /bin/bash -c 'df -h'
Filesystem      Size  Used Avail Use% Mounted on
none             97G  2.5G   95G   3% /
tmpfs           1.9G     0  1.9G   0% /dev
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/sda1        97G  2.5G   95G   3% /etc/cars
shm              64M     0   64M   0% /dev/shm
tmpfs           1.9G   12K  1.9G   1% /run/secrets/kubernetes.io/serviceaccount

kubectl exec -it shell-demo -- /bin/bash -c 'ls -l /etc/cars'
total 0
lrwxrwxrwx 1 root root 15 Feb 22 22:56 car.make -> ..data/car.make
lrwxrwxrwx 1 root root 16 Feb 22 22:56 car.model -> ..data/car.model
lrwxrwxrwx 1 root root 15 Feb 22 22:56 car.trim -> ..data/car.trim

kubectl exec -it shell-demo -- /bin/bash -c 'cat /etc/cars/car.make'
Ford
```

# delete configmap
```
kubectl delete configmap fast-cars
kubectl delete configmap colors
```

# use configmap as Environment Variables
```
- name: SPECIAL_LEVEL_KEY
  valueFrom:
    configMapKeyRef:
        name: special-config
        key: special.how
```

# use configmap as Volumes
```
volumes:
    - name: config-volume
      configMap:
        name: special-config
```
