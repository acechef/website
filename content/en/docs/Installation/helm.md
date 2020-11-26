---
title: "Helm Chart"
linkTitle: "Helm Chart"
weight: 30
date: 2020-11-25
description: >
  Install mysql operator by helm
---


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
$ helm list -A
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

