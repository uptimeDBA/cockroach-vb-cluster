---
title: Requirements
tags: 
keywords: 
last_updated: 
---

## Software Requirements

The following software components are required on the host machine. The versions listed are the versions used in this guide.
Versions greater than those listed should also work.

|--
| Software | Version
|:-|:-
| Cygwin* | 2.4.1
| VirtualBox | 5.0.14
| Vagrant | 1.8.1
|---

\*If you are using a Linux or Mac host, you don’t’ need Cygwin.


## Disk Space Requirements

Each virtual machine as a single 40Gb, dynamically allocated VMDK type disk. Because the disk is dynamically allocated, the actual disk size of each node is less than 3Gb when started. The amount of data loaded into the database will determine the final disk space used, up to 40Gb for each machine.

The default configuration (3 nodes), in it’s starting state, will require approx. 10Gb of host disk space.



