# Logging
```
kubernetes does not have a built-in cluster-wide logging utility.

Instead we would need to use a secondary product, like Prometheus or Fluentd
```

# Heapster
https://github.com/kubernetes/heapster/blob/master/docs/influxdb.md

```
Heapser is alose used for Horizontal Pod Autoscaling feature.
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
```

# Kubernetes logs
```
kubelet writes container logs to local files. The kubectl logs command allows you to retrieve these logs.

Fluentd is part of Cloud Native Computing Foundation and together with Prometheus, they make a nice combination for monitoring and logging.
https://kubernetes.io/docs/tasks/debug-application-cluster/logging-elasticsearch-kibana/

Fluentd agents run on each node via DaemonSet, they aggregate the logs, and feed them to an ElasticSearch instance prior to visualization in a Kibana dashbaord.
```

# log files on Nodes
```
(a) /var/log/kube-apiserver.log
Responsible for serving the API
(b) /var/log/kube-scheduler.log
Responsible for making scheduling decisions
(c) /var/log/kube-controller-manager.log
Controller that manages replication controllers
/var/log/containers
Various container logs
/var/log/pods/
More log files for current Pods.

Worker Nodes Files (on non-systemd systems)
(a) /var/log/kubelet.log
Responsible for running containers on the node
(b) /var/log/kube-proxy.log
Responsible for service load balancing
```

# add nginx to fluentd
```
<source>
  type tail
  path /var/log/httpd-access.log #...or where you placed your Apache access log
  pos_file /var/log/td-agent/httpd-access.log.pos # This is where you record file position
  tag nginx.access #fluentd tag!
  format nginx
  read_from_head true
</source>
```
