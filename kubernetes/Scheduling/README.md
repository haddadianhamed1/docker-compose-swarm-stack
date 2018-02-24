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
the larger and more diverse a Kubernetes deployment becomes the more admnstration of scheduling can be imporatnat. The kube-scheduler determines which nodes will run a Pod, using a topology-aware algorithm

The default scheduling decision can be affected through the use of Labels on nodes or Pods.
Labels of podAffinity, taints, and pod bingins allow for configuration from the Pod or the node perspective. Some like Tolerations allow a Pod to work with a node, even when the node has a taint that would otherwise preclude a Pod being scheduled.

Some settings will evict pods from a node should the required condition no longer be true, such as requiredDuringScheduling, RequiredDuringExecution
```

# predicates
```
The scheduler goes through a set of filters or predicates, to find available nodes, then ransk each node using priority functions. The node with the highest rank is selected to run the pod.

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

Currently there are more than ten included priorities, which range from checking the existence of a lable to choosing a node with the most requested CPU and memory usage. you can view a list of priorities at master/pkg/scheduler/algorithm/priorities
```


# Scheduling Decisions
```
Most Scheduling decisions can be made as part of the Pod specificaiton.

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
