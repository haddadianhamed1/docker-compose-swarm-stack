# troubelshooting
```
using shell inside a container

for containers that do not have a shell available we may need to deploy a second container.

Heapser which is opensource github.com/kubernetes/heapster

# logging Activity across all the node is another feature not part of Kubernetes. Using Fluentd can be useful data collector for a unified logginglayer. Fluentd.org

# Another Project from cncf.io combines logging, monitoring, and alerting and is called Prometheus. It can be found here https://prometheus.io -- it provides a time-series database, as well as integration with Grafana for visualization and dashboards.
```

## troubelshooting

# Busy Box
```
kubectl run busybox --image=busybox --command sleep 3600
kubectl exec -it <busybox_pod> -- /bin/sh
```

# Logs
```
kubectl logs pod-name
```

# Security Settings
```
RBAC provides access control
SELinux and AppArmor are also common issues, especially with network-centric application
```


# Links
```
General troubelshooting https://kubernetes.io/docs/tasks/debug-application-cluster/troubleshooting/
Application troubelshooting https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/
troubelshooting Clusters https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/
Debugging Pods https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/
Debugging Service https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/
```
