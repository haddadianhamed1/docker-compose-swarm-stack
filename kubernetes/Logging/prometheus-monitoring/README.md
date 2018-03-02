# Prometheus

# Step1
```
add my user to as admin
kubect create -f admin-user.yaml
```

# prometheus-operator
```
The Prometheus Operator for Kubernetes provides easy monitoring definitions for Kubernetes services and deployment and management of Prometheus instances.
Once installed, the Prometheus Operator provides the following features:

Create/Destroy: Easily launch a Prometheus instance for your Kubernetes namespace, a specific application or team easily using the Operator.

Simple Configuration: Configure the fundamentals of Prometheus like versions, persistence, retention policies, and replicas from a native Kubernetes resource.

Target Services via Labels: Automatically generate monitoring target configurations based on familiar Kubernetes label queries; no need to learn a Prometheus specific configuration language.



Deployment
image: quay.io/coreos/prometheus-operator:v0.16.1
serviceAccountName: prometheus-operator
```

# Kube-state-metrics
Metrics that are rather about cluster state than a single component's metrics is exposed by the add-on component kube-state-metrics.


# Node Exporter
Additionally, to have an overview of cluster nodes' resources the Prometheus node_exporter is used. The node_exporter allows monitoring a node's resources: CPU, memory and disk utilization and more.

# Once you complete this guide you will monitor the following:
```
cluster state via kube-state-metrics
nodes via the node_exporter
kubelets
apiserver
kube-scheduler
kube-controller-manager
```
## Kubernetes Metrics
# Prometheus Operator
```
The manifests used here use the Prometheus Operator, which manages Prometheus servers and their configuration in a cluster. Prometheus discovers targets through Endpoints objects, which means all targets that are running as Pods in the Kubernetes cluster are easily monitored. Many Kubernetes components can be self-hosted today. The kubelet, however, is not. Therefore the Prometheus Operator implements a functionality to synchronize the kubelets into an Endpoints object. To make use of that functionality the --kubelet-service argument must be passed to the Prometheus Operator when running it
```
