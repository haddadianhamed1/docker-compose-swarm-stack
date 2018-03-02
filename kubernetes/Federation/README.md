# Federation
```
Federation is when we add another Control Plane above our existing Kubernetes Cluster. The reasons we would do this would be advantages for higher availability, possible performance, and avoiding vendor lock.

We have Higher availability because each of our independent kubernetes cluster will copy their information to the federated Control Plane. This allows us to move objects from one cluster to another very easily.

Should a particular cluster fail, the objects created inside of that cluster would then be started on a different cluster without you having to do anything.

We can affect where objects are deployed through weights that allow us to move our data closer to the end user ( what we call locality of data) This can have advantages for performance. The ability to easily move resources allows Pods and their data to be located closer to the client to minimize latency. Moving data from one cluster, such as a public provider like GCE to private hosting like openStack is also easy.

In addition to the scalability and higher availability use, you can deploy federated resources, such as Federated Services, Federated Ingress, among others. This would allow client use of a single IP, but enjoy traffic routed via the shortest path to a cluster with available resources automatically.

e.g.
we have three stand-alone cluster, each with their own kube-apiserver, sscheduler, controller manager and etcd-based storage.
The federation-controller-manager connects to each local API server, both sending API calls as well as regular health interrogation.
A new federation API server with its dedicated etcd-based storage presents a cluster endpoint for tis federated cluster. Users creating resources on this federated endpoint will see them being replicated among the three individual clusters. Every 40 seconds, by default, the nodes clustercontroller will sync ClusterStatus to ensure the health of the cluster. If a member node does not respond properly, the manager control-loop will redeploy resources until the expected deployment state has been met.
```

# Kubefed
```
The kubefed command is included with the client ttarball called kubernetes-client-linux-amd64.tar.gz

kubefed init felloship \
 --host-cluster-context=rivendell \
 --dns-provider="google-clouddns" \
 --dns-zone-name="example.com." \
 --api-server-service-type="NodePort" \
 --apis-server-advertise-address="10.0.10.20"
```

# kubefed join
```
The kubefed join command can then be used to add clusters to the federation.

kubefed join gondor \
--host-cluster-context=rivendell \
-- cluster-context=gondor_needs-no_king \
--secret-name=11kingdom
```

# Note
```
Most of the resources that you can use in a typical cluster can be deployed in the same manner with a federation.

Federated Ingress only runs on GCE

e.g.
If you have 10 replicas and 5 clusters, there would be two replicas per cluster. For other features like rolling upgrades, the federated API server passes along the request for upgrade but no the specifics. Each cluster would use local parameters, like MaxUnavailable, while updating the local replicas.


Some resources like namespaces, when created with the federated server, will be created on each cluster. But when removed they are only removed from the federated API server. Each cluster retains the namespaces and all objects created within. An administrator would need to change the context to each cluster and delete the namespace manually to fully remove it, as well as the resources within.
```


# Balancing ReplicaSet
```
In addition to replicas being spread by default, you can re-balance the replicas, shceduling more pods on one cluster and less on another. This is done via an annotation in the manifest of replica sets. At the moment Deployment do not have a declared process for this, but it is expected to be similar.

By adjusting the weights, kubernetes will re-balance the pods across the federated cluster. you can start with even weights, and then use kubectl apply to update the values.

annotations:
  federation.kubernetes.io/replica-set-preferences: |
    {
      "rebalance" : true,
      "clusters" : {
        "new-york": {
          "minReplicas": 0,
          "maxReplicas": 20,
          "weight": 10
        },
        "berlin": {
          "minReplicas": 1,
          "maxReplicas": 200,
          "weight": 20
        }
      }
    }

In the example above the berlin cluster would be more likely to get replicas, with the weights being relative values, if you set a value of zero weight, all the replicas would run on other nodes.
```
