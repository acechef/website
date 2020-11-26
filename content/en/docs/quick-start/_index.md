---
title: "Quick Start"
linkTitle: "Quick Start"
weight: 2
description: >
  Quickly install the MySQL Operator and start the MySQL cluster
---

## Prerequisites

- MySQL operator requires Kubernetes v1.14.x or later or k3s.
- For high availability MySQL,at least 3 nodes k3s/k8s cluster.


> You can choose [Kubernetes Manifests](#deploy-mysql-operator-from-kubernetes-manifests) or [Helm](#deploy-mysql-operator-with-helm) to install MySQL operator

## Deploy MySQL operator from Kubernetes Manifests


1. Create a controlNamespace called "grds".

    ```bash
    kubectl create ns grds
    ```

2. Create a ServiceAccount and install cluster roles.

    ```bash
    kubectl -n grds create -f https://raw.githubusercontent.com/GrdsCloud/website/master/manifests/rbac.yaml
    ```

3. Apply the ClusterResources.

    ```bash
    kubectl -n grds create -f https://raw.githubusercontent.com/GrdsCloud/website/master/manifests/mysql.grds.cloud_mysqlclusters.yaml
    ```

4. Deploy the MySQL operator.

    ```bash
   kubectl -n grds create -f https://raw.githubusercontent.com/GrdsCloud/website/master/manifests/deployment.yaml
    ```

## Deploy MySQL operator with Helm

<p align="center"><img src="helm2.svg" width="150"></p>
<p align="center">

> Note: For the Helm-based installation you need [Helm](https://helm.sh/docs/intro/install/#helm) v3.2.4 or later.

1. Add operator chart repository.
    - Helm v3
    ```bash
    helm repo add grdscloud-stable https://grdscloud.github.io/charts/
    helm repo update
    ```

2. Install the MySQL Operator

    ```bash
    helm upgrade --install --wait --create-namespace --namespace grds mysql-operator grdscloud-stable/mysql-operator
    ```

> If you using k3s,sometimes helm will not access k3s cluster,please copy the k3s.yaml to .kube/config,refer to [k3s cluster access](https://rancher.com/docs/k3s/latest/en/cluster-access)

```
[root@10-10-120-194 ~]# helm list -A
Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version?timeout=32s": dial tcp [::1]:8080: connect: connection refused

cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
```

### Check the MySQL operator deployment

To verify that the installation was successful, complete the following steps.

1. Check the status of the pods. You should see a new mysql-operator pod

    ```bash
    $ kubectl get pods -n grds
    NAME                                        READY   STATUS    RESTARTS   AGE
    mysql-operator-76c44cdc5c-lw4z6             1/1     Running   0          53s
    ```

2. Check the CRDs. You should see the following MySQL cluster CRDs.
mysql-cluster-crd.png

    ```bash
    $ kubectl get crd | grep grds
    NAME                                    CREATED AT
    mysqlclusters.mysql.grds.cloud          2020-10-28T09:53:01Z
    ```

### Install the `grds` Client

During or after the installation of the MySQL Operator, download the `grds` client set up script. This will help set up your local environment for using the MySQL Operator:

```
curl https://raw.githubusercontent.com/GrdsCloud/grds/{{< param operatorVersion >}}/installers/kubectl/client-setup.sh > client-setup.sh
chmod +x client-setup.sh
```

When the MySQL Operator is done installing, run the client setup script:

```
./client-setup.sh
```

This will download the `grds` client and provide instructions for how to easily use it in your environment. 
It will prompt you to add some environmental variables for you to set up in your session, 
which you can do with the following commands:


```
export GRDS_CA_CERT="${HOME?}/.grds/grds/client.crt"
export GRDS_CLIENT_CERT="${HOME?}/.grds/grds/client.crt"
export GRDS_CLIENT_KEY="${HOME?}/.grds/grds/client.key"
export GRDS_APISERVER_URL='https://127.0.0.1:8443'
export GRDS_NAMESPACE=grds
```

If you wish to permanently add these variables to your environment, you can run the following:

```
cat <<EOF >> ~/.bashrc
export GRDS_CA_CERT="${HOME?}/.grds/grds/client.crt"
export GRDS_CLIENT_CERT="${HOME?}/.grds/grds/client.crt"
export GRDS_CLIENT_KEY="${HOME?}/.grds/grds/client.key"
export GRDS_APISERVER_URL='https://127.0.0.1:8443'
export GRDS_NAMESPACE=grds
EOF

source ~/.bashrc
```

**NOTE**: For macOS users, you must use `~/.bash_profile` instead of `~/.bashrc`

### Create a MySQL Cluster using client

Try creating a MySQL cluster called `my-cluster`:

```
grds mysql add my-cluster -n grds
```

Alternatively, because we set the `GRDS_NAMESPACE` environmental variable in our `.bashrc` file, 
we could omit the `-n` flag just run this:

```
grds mysql add my-cluster
```

Even with `GRDS_NAMESPACE` set, you can always overwrite which namespace to use by setting the `-n` flag 
for the specific command. For explicitness, we will continue to use the `-n` flag in the remaining examples of this quickstart.

If your cluster creation command executed successfully, you should see output similar to this:

```
$ grds mysql add my-cluster -n grds
MySQL cluster created, name: [my-cluster] namespace [grds].
```

This will create a MySQL cluster named `my-cluster`. It may take a few moments for the cluster to be availabled. 
You can see the status of this cluster using the [`grds mysql show`]({{  relref "/grds-client/_index.md"  }}) command:

```
grds mysql show my-cluster -w table
```

When everything is up and running, you should see output similar to this:

```
$ grds mysql show my-cluster -w table
MYSQL CLUSTER INFO:
+------------+-----------+---------+-------+-------+--------------+-----------+
|    NAME    | NAMESPACE | REPLICA | SLAVE | PORT  | ROOTPASSWORD |  STATUS   |
+------------+-----------+---------+-------+-------+--------------+-----------+
| my-cluster |      grds |       2 |     0 | 31756 |   Edjxlxb3qf | available |
+------------+-----------+---------+-------+-------+--------------+-----------+
MYSQL DATABASE INFO:
+-----------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------------+---------+-----------+
|         NAME          | NAMESPACE | CPUREQUEST | CPULIMIT | MEMORYREQUEST | MEMORYLIMIT | PVCSIZE |    NODEIP     |   NODENAME    |  ROLE   |  STATUS   |
+-----------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------------+---------+-----------+
| my-cluster-replica0-0 |      grds |          0 |        0 |             0 |           0 |    10Gi | 10.10.120.133 | 10-10-120-133 | standby | available |
| my-cluster-replica1-0 |      grds |          0 |        0 |             0 |           0 |    10Gi | 10.10.120.174 | 10-10-120-174 |  master | available |
+-----------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------------+---------+-----------+
```

## Connect to a MySQL Cluster

the `grds mysql show` command provides you the detailed information, information show you master database `PORT` and `ROOT PASSWORD` 
and you can connect to your MySQL cluster by node ip.

Below demonstrates how we can connect to `my-cluster`.

### Connecting via `mysql client`

Ensure you have installed the `mysql` client.

The MySQL Operator creates a service named \<cluster-name\>-primary and points to the master database. Get a list of all of the Services available in the `grds` namespace:

```
$ kubectl get services -n grds 
NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)           AGE
my-cluster-primary             NodePort    10.43.138.199   <none>        3306:31756/TCP    21m
my-cluster-primary-headless    ClusterIP   None            <none>        3306/TCP,22/TCP   21m
my-cluster-replica0-headless   ClusterIP   None            <none>        3306/TCP,22/TCP   21m
my-cluster-replica1-headless   ClusterIP   None            <none>        3306/TCP,22/TCP   21m
```

Let's connect the `my-cluster` cluster. Default the cluster master database expose services by [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport), 
It exposes the Service on each Node's IP at a static port, In this example nodePort is `31756`.



> If your app is running in the same k8s environment as the cluster, you can access the cluster master database directly using `<cluster-name>-primary-headless` [headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)

You can connect to the database with the following command:

```
mysql -h <node-ip> -u root -p <root-password> -P <node-port>
```

You should then be greeted with the MySQL prompt:

```
$ mysql -h 10.10.120.174 -u root -pEdjxlxb3qf -P31756
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 5360
Server version: 5.7.26-log MySQL Community Server - (GPL)

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]>
```
