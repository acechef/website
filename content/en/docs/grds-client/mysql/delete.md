---
title: "grds mysql delete"
linkTitle: "grds mysql delete"
weight: 5
description: >
   Delete mysql cluster.
---

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
