---
title: Shutdown the Database
tags: 
keywords: CockroachDB, install, guide
last_updated: 
summary: "Here's what to do when you want to shutdown a database node."
---

The `cockroach quit` command can be used to shutdown a database node. When all current requests have finished, the node will shutdown.


The third instance

```Shell

```


There doesn't seem to be a command to retrieve the http-port of a running node. Neither the `status` or the `ls` options of the `cockroach node` command shows this information. The `ps -ef | grep cockroach` command will show the http-port argument if originally supplied however.

{{site.data.alerts.warning}}
The Admin UI is served from the same cockroach executable that runs the database node. If you shutdown the database node that your Admin UI is connected to, it will stop working. You will need to reconnect to another operational node.
{{site.data.alerts.end}}








