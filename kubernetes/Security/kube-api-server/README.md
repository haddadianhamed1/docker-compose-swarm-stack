# Access the API


        Human User --------------->
        Pod  ---------------------> authentication --> authorization -- > admision control --> kubelet
( kubernetes service account)

# Authentication
```
Once a request reaches the API server securely, it will first go through any authenticaiton module that has been configured. The request can be rejected if authentication and passed to the authorized step.

# in the Straightforward form, authentication is done with certificates, tokens or basic authentication(i.e. username and password)

# Users are not created by the API, but should be managed by an external system
# System accounts are used by process to access the API (https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)

# Webhooks which can be used to verify bearer tokens and connection with External OpenID provider
# x509 Client Certs

# read more https://kubernetes.io/docs/admin/authentication/
```
# Authorization
```
At the authorization step, the request will be checked against existing policies. It will be authorized if the user has the permissions to perform the requested actions. The requests will go through the last step of admissions. Then the request will go through the last step of admissions.

# ABAC Attribute Based Access Control (https://kubernetes.io/docs/admin/authorization/abac/)
# RBAC Role Based Access Control (https://kubernetes.io/docs/admin/authorization/rbac/)
# webhook

they can be configured as kube-apiserver startup options.
--authorization-mode=ABAC
--authorization-mode=RBAC
--authorization-mode=Webhook
--authorization-mode=AlwaysDeny
--authorization-mode=AlwaysAllow
```

# RBAC
```
All resources are modeled API objects in kubernetes, from Pods to Namespaces. They also belong to API Groups, such as core and apps.
These resources allow operations such as Create, Read, Update, and delete
Operations are called verbs inside yaml files.
Rules are operations which can act upon an API Groups
Roles are group fo rules which affect a single namespace
ClusterRoles are similar to Roles but they have a scope of the entire cluster
```

# Admission Controller
```
Adminision Controllers will check the actual content of the objects being created and validate them before admitting the request.
```
