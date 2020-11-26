---
title: "grds mysql update"
linkTitle: "grds mysql add"
weight: 50
description: >
   Update mysql update.
---

#### Update Cluster

**Usage**:

```shell script
grds mysql update <clusterName> [flags]
```

**Flag**:

| CLI FLAG        | DESCRIPTION                                                  |
| --------------- | :----------------------------------------------------------- |
| --cpu           | Set the number of millicores to request for the CPU, e.g. "100m" or "0.1" |
| --cpu-limit     | Set the number of millicores to limit for the CPU, e.g. "100m" or "0.1" |
| --memory        | Set the amount of RAM to request, e.g. 1GiB. Overrides the default server value |
| --memory-limit  | Set the amount of RAM to limit, e.g. 1GiB.                   |
| --mode          | The mode of cluster, e.g. HACluster/Singleton                |
| --pvc-size      | The size of the PVC capacity for Database instances. Must follow the standard Kubernetes format, e.g. "10.1Gi" |
| --replica-count | The number of primary candidate to create as part of the cluster. |
| --slave-count   | The number of slave to create as part of the cluster         |

**Example:**

Add a slave to mysql-cluster-test cluster under grds namespace

```shell
$ grds mysql-cluster update my-cluster-test --slave-count=2
MySQL cluster updated, name: [my-cluster-test] namespace [grds].
$
$ grds mysql-cluster list -n grds -w table
+-----------------+-----------+---------+-------+
|      NAME       | NAMESPACE | REPLICA | SLAVE |
+-----------------+-----------+---------+-------+
| my-cluster-test |      grds |       2 |     2 |
+-----------------+-----------+---------+-------+
$
```

