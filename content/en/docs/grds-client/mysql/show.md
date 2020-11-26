---
title: "Grds MySQL Show"
linkTitle: "Grds MySQL Show"
weight: 4
description: >
   Show mysql cluster detail.
---

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

