# Custom Resource Definition
```
Custom Resource Definition allow our cluster to be rather flexible. We can add our own objects and our own controllers, or watch loops.

While adding an object is very straightforward it could be complex to add a watch loop, depending on the resource you are trying to monitor.

There are actually two ways of adding new resources. The simple way is adding a new object to the existing cluster. A potentially more complex way is what is called aggregated APIs.
This is where a secondary API server is added to your cluster. The API calls are then accepted by kube-apiserver and then passed along to your custom API server to actually be handled and taken care of.

The previous versions of Kubernetes used something called a Third Party Resource. Those are not supported anymore, and their configuration files need to be modified and switched over to being Custom Resource Definitions.

```
