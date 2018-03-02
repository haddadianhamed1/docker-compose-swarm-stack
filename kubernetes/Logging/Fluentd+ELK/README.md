# Fluentd
```
Logging is important to show errors, information and debugging data about the application.

# we are going to run ELK stack (ElasticSearch + Logstash + Kibana)

Fluentd (For Log Forwarding)
ElasticSearch (for log indexing)
Kibana (for visualisation)
LogTrail (plugin for Kibana an easy to use UI to show logs)
```

# label nodes
```
for i in `kubectl get node|cut -d ' ' -f 1| grep -i -v name`; do kubectl label node ${i} beta.kubernetes.io/fluentd-ds-ready=true; done

# Note: GKE already has these labels by default
kubectl get node --show-labels to verify
```
# give my user admin access to cluster
```
kubectl create -f Elastic-Search/admin-user.yaml
```
# create a storageclass volume for elastic Search in google cloud
```
kubectl create -f Elastic-Search/es-storage.yaml
```

# Create RBAC Role
```
kubectl create -f Elastic-Search/es-role.yaml
```

# create StatefulSet for ElasticSearch
```
Elastic Search needs to use StatefulSet for naming
kubectl create -f Elastic-Search/es-statefulset.yaml

kubectl get pods -n kube-system
NAME                                                  READY     STATUS    RESTARTS   AGE
elasticsearch-logging-0                               1/1       Running   0          38s
elasticsearch-logging-1                               1/1       Running   0          27s
```

# create ClusterIP service for database access for other pods for Elastic Search
```
kubectl create -f Elastic-Search/es-service.yaml
kubectl get svc -n kube-system
NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)         AGE
elasticsearch-logging   ClusterIP   10.7.243.201   <none>        9200/TCP        6s
```


# Fluentd
```
# craete Roles
kubectl create -f Fluentd/fluentd-role.yaml
# create configmap for fluentd
kubectl create -f Fluentd/fluentd-configmap.yaml
# create daemonset for fluentd
kubectl create -f Fluentd/fluentd-daemonset.yaml
```



# Kibana Deployment
```
# Create kibana Deployment
kubectl create -f Kibana/Kibana-deployment.yaml

# create Kibana Service LoadBalancer
kubectl create -f Kibana/kibana-service.yaml

kubectl get svc -n kube-system
NAME                    TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)          AGE
kibana-logging          LoadBalancer   10.7.250.236   35.199.2.228   5601:30431/TCP   2m

```
