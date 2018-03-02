# different types of volumes
```
# persisten storage Available
e.g.
Local Storage, Ceph, dynamic provisioned storage from a provider like Google or Amazon

When storage is given to a pod, all of the containers inside of the pod have equal access, just like an IP address. It is another way that containers can actually talk to each other, by writing to shared storage, so the other container can then read it.

```

1) emptyDir
2) hostPath
