# Scheduling
```
We can effect where pods will be deployed based off of several features which we set with labels.

Kube-scheduler agent then looks at labels, and looks at the labels of the nodes, to determine where a pod should be deployed. We have ability to configure affinity and anti-affinity

For example, for higher availability reasons, we may want to spread out our pods, so that they dont run on the same node. On the other hand for performance, we may want locality of data, we may want our pods to be running on the same nodes as much as possible.

We can taint a node. this is a label that is just a string declared for that node. Our pod then might avoid the node, unless the pod has a toleration. A toleration is just another label that allows it to run on a tainted node.

We can also set a NodeSelector and actually call out a particular node for a pod to run on. In a large and diverse environment, this may not be the easiest way to go about doing things.
```


# Kube Scheduler
```
the larger and more diverse a Kubernetes deployment becomes the more adminstration of scheduling can be important. The kube-scheduler determines which nodes will run a Pod, using a topology-aware algorithm

The default scheduling decision can be affected through the use of Labels on nodes or Pods.
Labels of podAffinity, taints, and pod begins allow for configuration from the Pod or the node perspective. Some like Tolerations allow a Pod to work with a node, even when the node has a taint that would otherwise preclude a Pod being scheduled.

Some settings will evict pods from a node should the required condition no longer be true, such as requiredDuringScheduling, RequiredDuringExecution
```

# predicates
```
The scheduler goes through a set of filters or predicates, to find available nodes, then ranks each node using priority functions. The node with the highest rank is selected to run the pod.

The predicates such as PodFitsHost or NoDiskConflict are evaluated in a particular and configurable order. In this way a node has at least amount of checks for new Pod deployment, which can be useful to exclude a node from unnecessary checks if the node is not in the proper condition.

There is a filter called HostNamePred, which is also known as HostName, which filters out nodes that do not match the node name specified in the pod specification.

Another Predicate is PodFitsResources to make sure that the available CPU and memory can fit the resources required by the Pod.

Scheduler can be updated by passing a configuration of kind: Policy

hardPodAffinitySymmetricWeight which deploys Pods such that if we set Pod A to run with podB, then Pod B should automatically be run with Pod A
```

# Priorities
```
Priorities are functions used to weight resources. Unless Pod and node affinity has been configured to the SelectorSpreadPriority setting, which ranks nodes based on the number of existing running pods, they will select the node with the least amount of Pods. This is basic way to spread Pods across the cluster.

The ImageLocalityPriorityMap favors nodes which already have downloaded container images. The total sum of image size is compared with the largest having the highest priority, but does not check the image about to be Used

Currently there are more than ten included priorities, which range from checking the existence of a label to choosing a node with the most requested CPU and memory usage. you can view a list of priorities at master/pkg/scheduler/algorithm/priorities
```


# Scheduling Decisions
```
Most Scheduling decisions can be made as part of the Pod specification.

# nodeName
# nodeSelector
# affinity
# schedulerName
# tolerations

nodeName and nodeSelector options will allow a Pod to be assigned to a single node or group of nodes with particular labels

Affinity and anti-affinity can be used to require or prefer which node is used by the scheduler. If using a preference instead, a matching node is chosen first, but other nodes would be used if no match is present.

The use of taints allows a node to be labeled such that pods would not be scheduled for some reason, such as the master node after initialization. A toleration allows a Pod to ignore the taint and be scheduled assuming other requirements are met.

Each Pod could then include a schedulerName to choose which schedule to use.
```

# Pod Affinity AntiAffinity
```
Pods which may communicate a lot or share data may operate best if co-located, which would be a form of affinity. For greater fault tolerance, you may want Pods to be as separate as possible, which would be anti-affinity. These settings are used by the scheduler based on the labels of Pods that are already running.

# Note : Cluster larger than several hundred nodes may see significant performance loss.

Pod Affinity rules use In, NotIn, Exists and DoesNotExist operators.

Use of requiredDuringSchedulingIngnoreDuringExecution will choose a node with the desired setting before those without.

With the use of podAffinity, the scheduler will try to schedule Pods together. The use of PodAntiAFfinity would cause the scheduler to keep Pods on different nodes.


# topologyKey allows a general grouping of Pod deployment. Affinity will try to run on nodes with declared topology key and running Pods with a particular label. topologyKey could be any legal key, with some important considerations.

If using requiredDuringScheduling and the adminission controller LimitPodHardAntiAffinityTopology setting the topologyKey must be set to kubernetes.io/hostname

If using preferredDuringScheduling, an empty topologyKey is assumed to be all or the combination of kubernets.io/hostname, failure-domain.beta.kubernetes.io/zone and failure-domain.beta.kubernetes.io/region

# example of Affinity and podAffinity settings can be seen below. This also requires a particular label to be matched when the Pod starts but not required if the label is later removed.

spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIngnoreDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values: - S1
        topologyKey: failure-domain.beta.kubernets.io/zone

# Inside the declared topology zone, the pod can be scheduled on a node running a pod with a key label security and a value of S1.
If this requirement is not met, the Pod will remain in a Pending state.


# PodAntiAFfinity
# Similarly to podAffinity we can try to avoid a node with a particular label. In this case the scheduler will prefer to avoid a node with a key set to security and value of S2

PodAntiAffinity:
  preferredDuringSchedulingIgnoreDuringExecution:
  - weight: 100
    podAffinityTerm:
      labelSelector:
        matchExpressions:
        - key: security
          operator: In
          values:
          - S2
      topologyKey: kubernets.io/hostname    
```

# Node Affinity AntiAffinity
```
Where Pod affinity/anti-affinity has to do with other Pods, the use of nodeAffinity allows Pod scheduling baed of node labels. this is similar, and will some day replace the use of the nodeSelector setting. The scheduler will not look at other Pods on the system but the labels of the nodes.
This should have much less performance impact on the cluster, even with a large number of nodes.

Node affinity rules use In, NotIn, Exists, DoesNotExist, GT, LT operators

requiredDuringSchedulingIngnoreDuringExecution and preferredDuringSchedulingIgnoreDuringExecution are in use. requiredDUringSchedulingRequiredDuringExection is planned for the future.

Until the nodeSelector has been fully deprecated, both the selector and the required labels must be met for a Pod to be scheduled.

spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIngnoreDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/colo-tx-name
            Operator: In
            values:
            - tx-aus
            - tx-dal
      preferredDuringSchedulingIgnoreDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: disk-speed
            operator: In
            Values:
            - fast
            - quick

# The first nodeAffinity rule requires a node with a key of kubernetes.io/colo-tx-name which has one f two possible values: tx-aus or tx-dal

# The second rule gives extra weight to nodes with a key of disk-speed with a value of fast or quick. The pod will be scheduled on some node - in any case, this just prefers a particular label.
```

# Taints
```
A node with a particular taint will repel Pods without tolerations for that taint. A taint is expressed as key-value:effect

The key and value used can be any legal string, and this allows flexibility to prevent Pods from running on nodes based off of any need. If Pod does not have an existing toleration, the scheduler will not consider the tainted node.

Three effects:
A) NoSchedule -- the scheduler will node schedule a Pod on this node, unless the pod has this toleration. Existing pods continue to run.

B) PreferNoSchedule -- The scheduler will avoid using this node, unless there are no untainted nodes for the Pods toleration. Existing Pods are unaffected.

C) NoExecute -- this taint will cause existing Pods to be evacuated and no further pods scheduled. should an existing Pod have a toleration, it will continue to run. If the PodTolerationSeconds is set they will remain for that many seconds, then evicted.

```


# Tolerations
```
Tolerations are used to schedule Pods on tainted nodes. This provides an easy way to avoid Pods using the node. Only those with a particular toleration would be scheduled.

An Operation can be included in a Pod specification, defaulting to Equal if not declared. The use of the operator Equal requires a value to match. The Exists operator should not be specified. If an Empty key uses the Exists operator, it will tolerate every taint. if there is no effect but a key and operator are declared, all effects are matched with the declared key.

tolerations:
- key: "server"
  operator: "Equal"
  value: "ap-east"
  effect: "NoExecute"
  tolerationSeconds: 3600

# in above example Pod will remain on the Node with key of server and value of ap-east for 3600 seconds after the node has been tainted with NoExecute. When the time runs out the pod will be evicted.
```
