---
title: "grds mysql list"
linkTitle: "grds mysql list"
weight: 30
description: >
   List mysql cluster.
---

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
