---
title: "Grds MySQL Add"
linkTitle: "Grds MySQL Add"
weight: 2
description: >
   Create mysql cluster.
---

#### Create Cluster

**Usage**:

```shell script
grds mysql add <clusterName> [flags]
```

**Flag**：

| CLI FLAG        | DESCRIPTION                                                  |
| --------------- | :----------------------------------------------------------- |
| cpu             | Set the number of millicores to request for the CPU, e.g. "100m" or "0.1" |
| --cpu-limit     | Set the number of millicores to limit for the CPU, e.g. "100m" or "0.1" |
| --labels        | The labels to apply to this cluster                          |
| --memory        | Set the amount of RAM to request, e.g. 1GiB. Overrides the default server value |
| --memory-limit  | Set the amount of RAM to limit, e.g. 1GiB.                   |
| --mode          | the mode of cluster, e.g. HACluster/Singleton (default "HACluster") |
| --pvc-size      | The size of the PVC capacity for Database instances. Must follow the standard Kubernetes format, e.g. "10.1Gi" (default "10Gi") |
| --replica-count | The number of primary candidate to create as part of the cluster. (default 2) |
| --slave-count   | The number of slave to create as part of the cluster         |
| --version       | the version of mysql databse, e.g. 5.6/5.7/8.0 (default "5.7") |

**Example:**

Create a cluster named *my-cluster-test* in the grds namespace

```shell
$ grds mysql add my-cluster-test \
  --cpu=0.5 --cpu-limit=2 --memory=2Gi --memory-limit=2Gi  \
  --pvc-size=10Gi --replica-count=2 --slave-count=1 -n grds
MySQL cluster created, name: [my-cluster-test] namespace [grds].
```