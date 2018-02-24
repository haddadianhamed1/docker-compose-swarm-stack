# google sdk
```
cloud.google.com/sdk
tar -xvzf google-cloud-sdk-173.0.0-darwin-x86_64.tar.gz
./google-cloud-sdk/install.sh

ln -s /Users/hamedh/google-cloud-sdk/bin/gcloud  /usr/local/bin/gcloud
##### source google-sdk #####
source /Users/hamedh/google-cloud-sdk/path.bash.inc
source /Users/hamedh/google-cloud-sdk/completion.bash.inc

```

# create a project
```
gcloud projects create --name "hamed-kubernetes"
```
# list projects
```
gcloud projects list
```
# configure gcloud CLI
```
gcloud init
```
# to list configuration
```
gcloud config list
```
# set default project
```
gcloud config set project ProjectID # e.g. hamed-kubernetes-195307
```
# authenticate
```
gcloud auth login #will bring up the browser for me to login
```

# enable billing on project
```
gcloud alpha billing accounts list
ID                    NAME                OPEN
01DF56-582E9C-6FEFCA  My Billing Account  True

gcloud alpha billing projects link hamed-kubernetes-195307 --billing-account 01DF56-582E9C-6FEFCA
billingAccountName: billingAccounts/01DF56-582E9C-6FEFCA
billingEnabled: true
name: projects/hamed-kubernetes-195307/billingInfo
projectId: hamed-kubernetes-195307
```

# enable API
```
# list available apis
gcloud service-management list  --available --page-size=10 --sort-by="NAME" | grep container
container.googleapis.com                  Google Kubernetes Engine API
containerregistry.googleapis.com    Google Container Registry API

# enable container service
gcloud service-management enable container.googleapis.com
```

# installing kubernetes tools
```
gcloud components install kubectl
```
# we might get the following error
```
The component manager is disabled for this installation
SOLUTION:
use the following command:
sudo sed -i -e ’s/true/false/‘ /Users/hamedh/google-cloud-sdk/lib/googlecloudsdk/core/config.json
```

# creaate cluster in google gcloud
```
gcloud container clusters create helloworld
or use ubuntu os default is chromeos
gcloud container clusters create --image-type=UBUNTU hamed-ubuntu
```

# list container cluster
```
gcloud container clusters list
NAME        ZONE        MASTER_VERSION  MASTER_IP       MACHINE_TYPE   NODE_VERSION  NUM_NODES  STATUS
helloworld  us-east4-a  1.7.12-gke.1    35.186.171.205  n1-standard-1  1.7.12-gke.1  3          RUNNING
```

# check kubernetes configure
```
kubectl config get-contexts
kubecctl config set current-context gke_hamed-kubernetes-195307_us-east4-a_helloworld
```

# check nodes
```
kubectl get node
NAME                                        STATUS    ROLES     AGE       VERSION
gke-helloworld-default-pool-9dd88111-frlt   Ready     <none>    1d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-n5rk   Ready     <none>    1d        v1.7.12-gke.1
gke-helloworld-default-pool-9dd88111-rb4t   Ready     <none>    1d        v1.7.12-gke.1
```
