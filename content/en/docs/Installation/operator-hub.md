---
title: "OperatorHub.io"
linkTitle: "OperatorHub.io"
weight: 40
date: 2020-11-25
description: >
    Install mysql operator from OpperatorHub.io
---


If your Kubernetes cluster is already running the [Operator Lifecycle Manager][OLM],
the PostgreSQL Operator can be installed as part of [Grds MySQL for Kubernetes][hub-listing]
that is available in OperatorHub.io.

[hub-listing]: https://operatorhub.io/operator/mysql
[OLM]: https://olm.operatorframework.io/


## Before You Begin

First, make sure OLM and the OperatorHub.io catalog are installed by running
`kubectl get CatalogSources --all-namespaces`.  You should see something similar to the following:

```shell
NAMESPACE   NAME                    DISPLAY               TYPE   PUBLISHER
olm         operatorhubio-catalog   Community Operators   grpc   OperatorHub.io
```

## Subscription MySQL Operator

Install the operator by running the following command

```shell
kubectl create -f https://operatorhub.io/install/mysql.yaml
```

This Operator will be installed in the "operators" namespace and will be usable from all namespaces in the cluster.

## Check the MySQL operator deployment

To verify that the installation was successful, complete the following steps.

1. Check the status of the pods. You should see a new mysql-operator pod

    ```bash
    $ kubectl get pods -n operator
    NAME                                        READY   STATUS    RESTARTS   AGE
    mysql-operator-76c44cdc5c-lw4z6             1/1     Running   0          53s
    ```

2. Check the CRDs. You should see the following MySQL cluster CRDs.
mysql-cluster-crd.png

    ```bash
    $ kubectl get crd | grep operator
    NAME                                    CREATED AT
    mysqlclusters.mysql.grds.cloud          2020-10-28T09:53:01Z
    ```