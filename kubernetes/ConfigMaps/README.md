# ConfigMaps
```
most use cases are configuration files
lets say we have a file that contains configuration caleld config.js
```

# create configmap
```
kubectl create configmap foobar --from-file=config.js
kubectl get configmap
kubectl get configmap foobar -o yaml
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
