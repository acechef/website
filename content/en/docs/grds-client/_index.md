---
title: "Using the grds Client"
linkTitle: "Using the grds Client"
weight: 4
description: >
  Here you can see the user manual for the grds client
---

## Global
**Command**：

| COMMAND       | DESCRIPTION                        |
| ------------- | ---------------------------------- |
| mysql | MySQL Cluster Lifecycle Management |

**Flag**：

| CLI FLAG                   | DESCRIPTION                                                  |
| -------------------------- | ------------------------------------------------------------ |
| --endpoint                 | gRPC endpoints (default "127.0.0.1:8443")                    |
| --namespace                | The namespace to use for grds requests. (default "grds")     |
| --write-out                | set the output format ( simple, table) (default "simple")    |
| --cacert                   | verify certificates of TLS-enabled secure servers using this CA bundle |
| --cert                     | identify secure client using this TLS certificate file       |
| --key                      | identify secure client using this TLS key file               |
| --insecure-skip-tls-verify | skip server certificate verification (CAUTION: this option should be enabled only for testing purposes) |
| --debug                    | enable client-side debug logging                             |

### MySQL Cluster Lifecycle Management

**Usage**:

```shell script
grds mysql [command]
```

**Command**：

| COMMAND | DESCRIPTION                                 |
| ------- | ------------------------------------------- |
| add     | Add a mysql cluster into the k8s cluster    |
| delete  | Delete a mysql cluster from the k8s cluster |
| list    | List mysql cluster in the cluster           |
| Update  | Update a mysql cluster in the k8s cluster   |

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

#### List Cluster

**Usage**:

```shell script
grds mysql list [options] [flags]
```

**Flag**:

| CLI FLAG   | DESCRIPTION                           |
| ---------- | ------------------------------------- |
| --all      | shows all mysql clusters              |
| --selector | selector of the mysql cluster to list |

**Example:**

List all mysql cluster under grds namespace

```shell
$ grds mysql-cluster list --all -n grds -w table
+-----------------+-----------+---------+-------+
|      NAME       | NAMESPACE | REPLICA | SLAVE |
+-----------------+-----------+---------+-------+
| my-cluster-test |      grds |       2 |     1 |
+-----------------+-----------+---------+-------+
```

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

#### Delete Cluster

**Usage**:

```shell script
grds mysql delete [options] [flags]
```

**Flag**:

| CLI FLAG   | DESCRIPTION                                        |
| ---------- | -------------------------------------------------- |
| --all      | Delete all clusters under the specified namespace. |
| --selector | The selector to use for delete cluster filtering   |

**Example:** 

Delete my-cluster-test cluster under grds namespace

```shell
$ grds mysql-cluster delete my-cluster-test -n grds
MySQL cluster deleted, name: [my-cluster-test] namespace [grds].
```

### Show Cluster

**Usage**:

```shell script
grds mysql show <clusterName> [flags]
```

**Example:** 

```shell
$ grds  mysql show my-cluster-test  -w table
MYSQL CLUSTER INFO:
+-----------------+-----------+---------+-------+-----------+-------+--------------+
|      NAME       | NAMESPACE | REPLICA | SLAVE |  STATUS   | PORT  | ROOTPASSWORD |
+-----------------+-----------+---------+-------+-----------+-------+--------------+
| my-cluster-test |      grds |       2 |     1 | available | 30442 |   Qkrsb9ttee |
+-----------------+-----------+---------+-------+-----------+-------+--------------+
MYSQL DATABASE INFO:
+----------------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------+-----------+
|            NAME            | NAMESPACE | CPUREQUEST | CPULIMIT | MEMORYREQUEST | MEMORYLIMIT | PVCSIZE |   NODENAME    |  ROLE   |  STATUS   |
+----------------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------+-----------+
| my-cluster-test-replica0-0 |      grds |          0 |        2 |             0 |         2Gi |    10Gi | 10-10-120-133 |  master | available |
| my-cluster-test-replica1-0 |      grds |          0 |        2 |             0 |         2Gi |    10Gi | 10-10-120-174 | standby | available |
|   my-cluster-test-slave0-0 |      grds |          0 |        2 |             0 |         2Gi |    10Gi | 10-10-120-232 |   slave | available |
+----------------------------+-----------+------------+----------+---------------+-------------+---------+---------------+---------+-----------+
```

