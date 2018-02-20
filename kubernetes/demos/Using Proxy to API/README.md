# Another way to interact with the API is via a proxy. The proxy can be run from a node or from within a Pod through the use of a sidecar.

# Start the Proxy while setting the API prefix and nothing else:
```
kubectl proxy --api-prefix=/ &
```

# now curl localhost port 80001
```
curl http://127.0.0.1:8001/api/
curl https://127.0.0.1:80001/api/v1/namespaces
```
