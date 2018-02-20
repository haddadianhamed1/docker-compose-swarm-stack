# CPU and Memory Constraints for deployment

# Use a container called stress, which we will name hog, to generate load. Verify you have a container running.
```
kubectl run hog --image vish/stress
kubectl get deployments
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hog       1         1         1            1           1m
```

# We will use the YAML output to create our own configuration file.
```
kubectl get deployment hog -o yaml > hog.yaml

```
# edit the yaml file
```
We will need to remove the status output, creationTimestamp and other settings, as we don’t want to set unique

generated parameters. We will also add in memory limits found below.

vim hog.yaml
.
imagePullPolicy: Always
name: hog
resources: # Edit to remove {}
limits: # Add these 4 lines
memory: "4Gi"
requests:
memory: "2500Mi"
terminationMessagePath: /dev/termination-log
terminationMessagePolicy: File

```

# replace deployment

```
kubectl replace -f hog.yaml
```

# lets consume memory and cpu
```
$ vim hog.yaml
resources:
limits:
cpu: "1"
memory: "4Gi"
requests:
cpu: "0.5"
memory: "500Mi"
args:
- -cpus
- "2"
- -mem-total
- "950Mi"
- -mem-alloc-size
- "100Mi"
- -mem-alloc-sleep
- "1s"

```
