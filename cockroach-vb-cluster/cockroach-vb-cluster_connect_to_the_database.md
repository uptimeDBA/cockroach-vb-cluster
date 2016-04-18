---
title: Connect to the Database
tags: 
keywords: 
last_updated: 
summary: "Use the built-in client software to connect to the cluster from the client machine."
---

The `cockroach` executable contains a built-in client that enables you to connect to a cockroachDB cluster and execute SQL statements.

As with starting the database nodes, there are two ways to connect to the cluster:

- **Secure**
- **Insecure**

{{site.data.alerts.important}}
You must connect to the database using the same method that you started the database nodes with.
{{site.data.alerts.end}}

For example, If you have started the cluster in **secure** mode and attempt to connect using the built-in client in **insecure** mode:

```Shell
[roachdb@client ~]$ cockroach sql --url=postgresql://root@nodeA:26257?sslmode=disable
# Welcome to the cockroach SQL interface.
# All statements must be terminated by a semicolon.
# To exit: CTRL + D.
root@nodeA:26257> show databases;
pq: cleartext connections are not permitted
root@nodeA:26257>
```


## Insecure Mode

On the client machine, as the `roachdb` user, execute the `cockroach sql --url postgresql://root@nodeA:26257?sslmode=disable` command. 

```Shell
[roachdb@client ~]$ cockroach sql --url=postgresql://root@nodeA:26257?sslmode=disable
# Welcome to the cockroach SQL interface.
# All statements must be terminated by a semicolon.
# To exit: CTRL + D.
root@nodeA:26257> show databases;
+----------+
| Database |
+----------+
| system   |
+----------+
root@nodeA:26257> set database=system;
SET
root@nodeA:26257> show tables;
+------------+
|   Table    |
+------------+
| descriptor |
| eventlog   |
| lease      |
| namespace  |
| rangelog   |
| ui         |
| users      |
| zones      |
+------------+
root@nodeA:26257> ^D
[roachdb@client ~]$
```


## Secure Mode

On the client machine, as the `roachdb` user, in the $HOME directory, execute the `cockroach sql --ca-cert=certs/ca.cert --cert=certs/root.cert --key=certs/root.key --user=root --host=nodeA --port=26257 --database=system` command. 


<!--
From $HOME

`cockroach sql --url=postgresql://root@nodeA:26257/root?sslcert=certs/maxroach.crt&sslkey=certs/maxroach.key&sslmode=verify-full&sslrootcert=certs/ca.crt`

`postgresql://root@nodeA:26257?sslcert=/home/roachdb/certs/root.cert&sslkey=/home/roachdb/certs/root.key&sslmode=verify-full&sslrootcert=/home/roachdb/certs/ca.cert`

 postgresql://root@nodeA:26257?sslcert=/home/roachdb/certs/nodeA.cert&sslkey=/home/roachdb/certs/nodeA.key&sslmode=verify-full&sslrootcert=/home/roachdb/certs/ca.cert

From docs:
postgresql://root@<node1-hostname>:26257/?sslcert=root.cert&sslkey=root.key&sslmode=verify-full&sslrootcert=ca.cert
postgresql://root@nodeA:26257?sslcert=root.cert&sslkey=root.key&sslmode=verify-full&sslrootcert=ca.cert

postgresql://myuser@localhost:26257/mydb
postgresql://root@nodeA:26257/system
-->

```Shell
[roachdb@client ~]$ cockroach sql --ca-cert=certs/ca.cert --cert=certs/root.cert --key=certs/root.key --user=root --host=nodeA --port=26257 --database=system
# Welcome to the cockroach SQL interface.
# All statements must be terminated by a semicolon.
# To exit: CTRL + D.
root@nodeA:26257> show database;
+----------+
| DATABASE |
+----------+
| system   |
+----------+
root@nodeA:26257> show tables;
+------------+
|   Table    |
+------------+
| descriptor |
| eventlog   |
| lease      |
| namespace  |
| rangelog   |
| ui         |
| users      |
| zones      |
+------------+
root@nodeA:26257> ^D
[roachdb@client ~]$
```


## What's Next?

[Monitor the database](cockroach-vb-cluster_monitor_the_database).
