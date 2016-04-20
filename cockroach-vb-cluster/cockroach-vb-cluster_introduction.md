---
title: Introduction
tags: 
keywords: CockroachDB, Install, Setup, Guide, Tutorial
last_updated: 
summary: "All the little things you need to know before you get going."
---

## Audience

This guide is intended for people wishing to setup their own CockroachDB cluster to evaluate it’s functionality and learn how it works. Architects, Database Administrators, DevOps etc. It assumes a proficient level of computing skills but previous experience with the related toolset (VirtualBox, Vagrant, etc) is not required.

{{site.data.alerts.important}}
It is not a guide for setting up a development environment for hacking the code or for running performance tests. Should you wish to contribute to the Cockroach open source project, take a look at the Contribute to CockroachDB page on the CockroachLabs website.
{{site.data.alerts.end}}

{{site.data.alerts.warning}}
This guide is based on a Beta version of CockroachDB. The CockroachDB community is working hard to make it the best distrubuted SQL database there is and things are changing fast so this guide may not exactly reflect the current state of the software. If you encounter errors or differences, please leave a comment so I can improve the guide.
{{site.data.alerts.end}}


## Related Information

The best place is the official [CockroachDB Docs](https://www.cockroachlabs.com/docs/) on the [CockroachLabs](https://www.cockroachlabs.com/) website.

You can connect to the CockroachDB community in a number of ways:

1. Twitter using @cockroachdb
2. Facebook at [https://www.facebook.com/cockroachlabs/](https://www.facebook.com/cockroachlabs/)
3. Google Groups at [https://groups.google.com/forum/#!forum/cockroach-db](https://groups.google.com/forum/#!forum/cockroach-db)
4. Reddit at [https://www.reddit.com/r/CockroachDB/](https://www.reddit.com/r/CockroachDB/)


## Conventions

The following text conventions are used in this guide:

|---
| Convention | Meaning 
|:-|:-
| **boldface** | Boldface type indicates an item of interest.
| <*Italic*> | Italic type surrounded by angled brackets <>, indicates a substitution value that needs to be replaced by the user.
| `monospace` | Monospace type in a shaded box indicates command output or file listings.
|---


In output listings, the line **<<output snip>>** indicates that some output has been removed for brevity.

Some of the commands issued from the Windows command prompt of my host machine may look a little strange in that they are Linux commands, not Windows commands. For example; **mv** instead of **move**, **ls** instead of **dir**, etc.

That’s because I have [Cygwin](https://www.cygwin.com/) installed on my Windows host machine and have **C:\cygwin64\bin** in my **%PATH%** environment variable. 

I’m also more comfortable with Linux than Windows.


## Intended Use

The cluster is designed for functional testing, evaluation and experimentation. It’s not a configuration that should be used for production data as all the nodes are on a single host and if you are going with virtual machines, a [type 1 hypervisor](https://en.wikipedia.org/wiki/Hypervisor) is probably a better choice for production.

The guide does make some concessions toward a production configuration in order to make it as close to what you would be using in real life, without making the configuration too complicated. Things like:

-   Uses SSH authenication to login to the operating system account of each cluster node instead of password authenication, although password authentication is still enabled.

-   Generates SSH key pairs for each cluster node so you can operate the cluster in **secure** mode.

-   Uses a separate virtual machine for each CockroachDB instance instead of putting them all on one machine.

-   Uses a user account called `roachdb` to own and run the CockroachDB software from so it doesn't run as the root user.

-   Uses a client machine for connecting to the cluster and running database tasks. The client machine does not run an instance of CockroachDB.

-   Has SELinux enabled in "Enforcing" mode on each node.

-   Has a firewall (firewalld) running on each node with the necessary ports open.

This guide is written using a Windows 10 host machine but the instructions for a Mac or Linux host have been included. 


## What's Next?

The [Overview](cockroach-vb-cluster_overview) section will give you a high level description of what you will be building and how you will build it.

