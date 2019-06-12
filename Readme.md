# TK8 addon - EFK

## What are TK8 addons?

- TK8 add-ons provide freedom of choice for the user to deploy tools and applications without being tied to any customized formats of deployment.
- Simplified deployment process via CLI (will also be available via TK8 web in future).
- With the TK8 add-ons platform, you can also build your own add-ons.

## What is EFK?

EFK stands for:

**E** - Elasticsearch

**F** - Fluentd

**K** - Kibana

A well-known logging stack for visualizing the centralized logging.

**Elasticsearch** is used as a centralized place to store logs.

**Fluentd** is a popular open-source data collector that we'll set up on our Kubernetes nodes to tail container log files, filter and transform the log data, and deliver it to the Elasticsearch cluster, where it will be indexed and stored.

**Kibana** provides a nice GUI to visualize your logs, create dashboards, alerting via Watcher, etc.

## Prerequisites

A Kubernetes cluster

## Get Started

You can install EFK stack on the Kubernetes cluster via TK8 addons functionality.

What do you need:
- tk8 binary

## Deploy EFK on the Kubernetes Cluster

Run:
```
$ tk8 addon install efk
Search local for efk
check if provided a url
Search addon on kubernauts space.
Cloning into 'efk'...
Install efk
execute main.sh
Creating main.yaml
add  ./elasticsearch/efk-namespace.yaml
add  ./elasticsearch/elasticsearch.yaml
add  ./kibana/kibana.yaml
add  ./fluentd/fluentd.yaml
apply efk/main.yml
namespace/efk created
service/elasticsearch created
statefulset.apps/elasticsearch created
deployment.extensions/kibana created
service/kibana created
serviceaccount/fluentd created
clusterrole.rbac.authorization.k8s.io/fluentd created
clusterrolebinding.rbac.authorization.k8s.io/fluentd created
daemonset.extensions/fluentd created
efk installation complete
```
This command will clone the https://github.com/kubernauts/tk8-addon-efk repository locally and create the EFK stack.

This command also creates:

- A separate namespace efk for installing components
- An HA Elasticsearch cluster (3 replicas)
- Deploys fluentd as a Daemonset on all worker nodes
- Kibana is exposed as a NodePort service. This can easily be changed to a LoadBalancer type, if required.

If all goes, you should all resources in Running state:
```
$ kubectl get all -n efk
NAME                          READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0           1/1     Running   0          2m39s
pod/elasticsearch-1           1/1     Running   0          2m25s
pod/elasticsearch-2           1/1     Running   0          2m10s
pod/fluentd-9dbgt             1/1     Running   0          2m37s
pod/fluentd-9tdcc             1/1     Running   0          2m37s
pod/fluentd-d2kqr             1/1     Running   0          2m37s
pod/fluentd-tjw9j             1/1     Running   0          2m37s
pod/fluentd-x7qkz             1/1     Running   0          2m37s
pod/kibana-5f469fb788-rtsqx   1/1     Running   0          2m39s
 
NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/elasticsearch   ClusterIP   None           <none>        9200/TCP,9300/TCP   2m41s
service/kibana          NodePort    10.43.54.114   <none>        5601:31464/TCP      2m39s
 
NAME                     DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/fluentd   5         5         5       5            5           <none>          2m38s
 
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana   1/1     1            1           2m40s
 
NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-5f469fb788   1         1         1       2m40s
 
NAME                             READY   AGE
statefulset.apps/elasticsearch   3/3     2m40s
```

## Accessing Kibana UI

Since we're exposing Kibana service as a NodePort, you can open http://worker-node-ip:nodeport in the browser and you should be greeted with a welcome screen!

Get started with a sample data or explore on your own, it's all up to you.

## Uninstalling EFK

For removing EFK stack from your cluster, we can use TK8 addon's destroy functionality. Run:
```
$ tk8 addon destroy efk
Search local for efk
Addon efk already exist
Found efk local.
Destroying efk
execute main.sh
Creating main.yaml
add  ./elasticsearch/efk-namespace.yaml
add  ./elasticsearch/elasticsearch.yaml
add  ./kibana/kibana.yaml
add  ./fluentd/fluentd.yaml
delete efk from cluster
namespace "efk" deleted
service "elasticsearch" deleted
statefulset.apps "elasticsearch" deleted
deployment.extensions "kibana" deleted
service "kibana" deleted
serviceaccount "fluentd" deleted
clusterrole.rbac.authorization.k8s.io "fluentd" deleted
clusterrolebinding.rbac.authorization.k8s.io "fluentd" deleted
daemonset.extensions "fluentd" deleted
efk destroy complete
```
