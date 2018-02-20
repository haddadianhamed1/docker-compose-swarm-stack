# This type of volume mounts a file or directory from the host node’s filesystem into your pod.
```
IMPORTANT: hostPath is for single node testing
Kubernetes supports hostPath for development and testing on a single-node cluster. A hostPath PersistentVolume uses a file or directory on the Node to emulate network-attached storage.

In a production cluster, you would not use hostPath. Instead a cluster administrator would provision a network resource like a Google Compute Engine persistent disk, an NFS share, or an Amazon Elastic Block Store volume. Cluster administrators can also use StorageClasses to set up dynamic provisioning.
```

# create directory
```
minikube ssh
sudo su -
mkdir /mnt/data
echo 'Hello from Kubernetes storage' > /mnt/data/index.html
```

# create a persistent volume
```
kubectl create -f hostpath-persistent-volume.yaml

kubectl get pv
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
task-pv-volume   10Gi       RWO            Retain           Available             manual                   1m
```

# above we created a persistent
```
The configuration file specifies that the volume is at /mnt/data on the cluster’s Node. The configuration also specifies a size of 10 gibibytes and an access mode of ReadWriteOnce, which means the volume can be mounted as read-write by a single Node
```

# create a persistent volume claim
```
kubectl create -f hostpath-persistent-volume-claim.yaml
persistentvolumeclaim "task-pv-claim" created

kubectl get pvc
NAME            STATUS    VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS   AGE
task-pv-claim   Bound     task-pv-volume   10Gi       RWO            manual         12s
```

# create a pod
```
kubectl create -f pod.yaml
pod "task-pv-pod" created
hamedh-mv-ltmp-x:hostPath hamedh$ kubectl get pods
NAME          READY     STATUS    RESTARTS   AGE
task-pv-pod   1/1       Running   0          3s
```
